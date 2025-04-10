set shell := ["fish", "-c"]
set positional-arguments

export FLAKE := `echo $PWD`


@default:
    just --list

@test:
    nh os test $FLAKE

@switch:
    nh os switch $FLAKE

@deploy:
    echo -e "Rebuilding new generation...\n"

    nh os switch $FLAKE

    echo -e "\n---\n\n$(date '+%x %X')" >> $FLAKE/build.log
    nvd diff $(command ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2) >> $FLAKE/build.log

    git add -A
    git commit -m "deployed $(nixos-rebuild list-generations --flake $FLAKE | grep -oP '[0-9]*(?= current)')"

@update:
    echo -e "Updating flake and git fetcher inputs...\n"

    nix flake update
    fd -e nix --exec update-nix-fetchgit

    git add -A
    git commit -m "chore: update inputs"

alias pf := prefetch

@prefetch url:
    nix store prefetch-file --json $argv[2] | jq -r .hash

@gc:
    nh clean all -k 5

@optimise:
    nix store optimise -v
