set shell := ["fish", "-c"]

export NH_FLAKE := `echo $PWD`
export NIXPKGS_ALLOW_UNFREE := "1"
profiles-path := "/nix/var/nix/profiles"

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
    nvd diff \
    $(command rg -N '>>> ({{ profiles-path }}/system-[0-9]+-link)' --only-matching --replace '$1' build.log | tail -1) \
    $(command ls -d1v {{ profiles-path }}/system-*-link | tail -n 1) \
    >> build.log

    git add -A
    git commit -m "deployed $(nixos-rebuild list-generations --flake $NH_FLAKE --json | jaq '.[0].generation')"

[group('SYSTEM')]
@get-updates: check
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

[group('MAINTENANCE')]
@gc:
    nh clean all -k 5

[group('MAINTENANCE')]
@optimise:
    nix store optimise -v

alias pf := prefetch

[group('TOOLS')]
@prefetch url:
    nix store prefetch-file --json {{ url }} | jaq -r .hash

[group('TOOLS')]
@search:
    ns

[group('TOOLS')]
@explore name:
    yazi $(nix eval --raw nixpkgs#{{ name }})

[group('TOOLS')]
@repl:
    nix repl --expr \
    "let \
        flake = builtins.getFlake (toString ./.); \
        nixpkgs = import <nixpkgs> {}; \
    in \
        {inherit flake;} // flake // builtins // nixpkgs // nixpkgs.lib // \
        flake.nixosConfigurations // flake.nixosConfigurations.nixos.config.home-manager.users"

[group('TOOLS')]
@debug-nur:
    nix flake update nur-vortriz
