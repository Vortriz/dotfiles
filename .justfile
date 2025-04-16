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
    nh os switch $FLAKE

    echo -e "\n---\n\n$(date '+%x %X')" >> $FLAKE/build.log
    nvd diff $(command rg -N '>>> (/nix/var/nix/profiles/system-[0-9]+-link)' --only-matching --replace '$1' build.log | tail -1) $(command ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 1) >> $FLAKE/build.log

    git add -A
    git commit -m "deployed $(nixos-rebuild list-generations --flake $FLAKE | grep -oP '[0-9]*(?= current)')"

@update:
    echo -e "Updating flake and git fetcher inputs...\n"

    nix flake update
    fd -e nix --exec update-nix-fetchgit

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