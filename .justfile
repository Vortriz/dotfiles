set shell := ["fish", "-c"]
set positional-arguments

export FLAKE := `echo $PWD`


@default:
    just --list

@test *args: fmt
    nh os test $FLAKE $argv[2..-1]

@switch *args: fmt
    nh os switch $FLAKE $argv[2..-1]

@deploy *args:
    nh os switch $FLAKE $argv[2..-1]

    echo -e "\n---\n\n$(date '+%x %X')" >> $FLAKE/build.log
    nvd diff $(command rg -N '>>> (/nix/var/nix/profiles/system-[0-9]+-link)' --only-matching --replace '$1' build.log | tail -1) $(command ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 1) >> $FLAKE/build.log

    just fmt

    git add -A
    git commit -m "deployed $(nixos-rebuild list-generations --flake $FLAKE | grep -oP '[0-9]*(?= current)')"

@update:
    echo -e "Updating flake and fetchgit inputs...\n"

    nix flake update
    for i in $(command fd sources.toml); set o $(echo $i | sed 's/.toml//'); nvfetcher -c $i -o $o; end

    just fmt

    git add -A
    git commit -m "chore: update inputs"

alias pf := prefetch

@fmt:
    nix fmt .

@gc:
    nh clean all -k 5

@optimise:
    nix store optimise -v

@prefetch url:
    nix store prefetch-file --json $argv[2] | jq -r .hash
