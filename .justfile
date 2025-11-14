set shell := ["fish", "-c"]

export NH_FLAKE := `echo $PWD`
export NIXPKGS_ALLOW_UNFREE := "1"
profiles-path := "/nix/var/nix/profiles"
system := `echo $system`

@default:
    just --list

[group('SANITY')]
@fmt:
    nix fmt

[group('SANITY')]
@check: fmt
    nix flake check

[group('SYSTEM')]
@test *args:
    nh os test {{ args }}

[group('SYSTEM')]
@switch *args:
    nh os switch {{ args }}

[group('SYSTEM')]
@deploy *args: check
    nh os switch {{ args }}

    echo -e "\n---\n\n$(date '+%x %X')" >> build.log
    just diff >> build.log

    git add -A
    git commit -m "deployed $(nixos-rebuild list-generations --flake $NH_FLAKE --json | jaq '.[0].generation')"

[group('SYSTEM')]
@get-updates:
    echo -e "Updating flake and fetchgit inputs...\n"

    nix flake update
    for i in $(command fd sources.toml); \
        set o $(echo $i | sed 's/.toml//'); \
        nvfetcher -c $i -o $o; \
    end

[group('SYSTEM')]
@update: get-updates
    git add -A
    git commit -m "chore: update inputs"

[group('SYSTEM')]
@build-iso:
    cp $(nix build .#nixosConfigurations.iso.config.system.build.isoImage --no-link --print-out-paths)/iso/* \
        /mnt/HOUSE/downloads/compressed/ISO
    echo "ISO built and copied!"

[group('MAINTENANCE')]
@gc:
    nh clean all -k 5 --optimise

alias pf := prefetch

[group('TOOLS')]
@prefetch url:
    nix store prefetch-file --json {{ url }} | jaq -r .hash

[group('TOOLS')]
@search:
    ns

[group('TOOLS')]
@repl:
    nix repl --expr \
    "let \
        flake = builtins.getFlake (toString ./.); \
        nixpkgs = flake.inputs.nixpkgs; \
        pkgs = nixpkgs.legacyPackages.{{ system }}; \
    in \
        {inherit flake pkgs;} // builtins // nixpkgs.lib // \
        flake.nixosConfigurations.nixos.config // flake.nixosConfigurations.nixos.config.home-manager.users"

[group('TOOLS')]
@diff:
    dix \
    $(command rg -N '>>> ({{ profiles-path }}/system-[0-9]+-link)' --only-matching --replace '$1' build.log | tail -1) \
    /run/current-system

[group('TOOLS')]
@nur-status:
    if test $(git ls-remote https://github.com/Vortriz/nur-packages refs/heads/main | cut -f1) \
    = $(curl -s https://raw.githubusercontent.com/nix-community/nur-combined/refs/heads/main/repos.json.lock | jaq -r .repos.Vortriz.rev); \
        echo "NUR is up to date!"; \
    else echo "NUR is not updated yet :("; \
    end
