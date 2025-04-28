set shell := ["fish", "-c"]
set positional-arguments

export NH_FLAKE := `echo $PWD`


@default:
    just --list

@check:
    nix flake check

@test *args:
    nh os test $FLAKE $argv[2..-1]

@switch *args:
    nh os switch $FLAKE $argv[2..-1]

@deploy *args: check
    nh os switch $FLAKE $argv[2..-1]

    echo -e "\n---\n\n$(date '+%x %X')" >> $FLAKE/build.log
    nvd diff $(command rg -N '>>> (/nix/var/nix/profiles/system-[0-9]+-link)' --only-matching --replace '$1' build.log | tail -1) $(command ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 1) >> $FLAKE/build.log

    git add -A
    git commit -m "deployed $(nixos-rebuild list-generations --flake $FLAKE | grep -oP '[0-9]*(?= current)')"

@update: check
    echo -e "Updating flake and fetchgit inputs...\n"

    nix flake update
    for i in $(command fd sources.toml); set o $(echo $i | sed 's/.toml//'); nvfetcher -c $i -o $o; end

    git add -A
    git commit -m "chore: update inputs"

alias pf := prefetch

@gc:
    nh clean all -k 5

@optimise:
    nix store optimise -v

@prefetch url:
    nix store prefetch-file --json $argv[2] | jq -r .hash
