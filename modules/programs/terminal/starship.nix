{
    unify.home = {pkgs, ...}: {
        programs.starship = {
            enable = true;

            settings =
                (pkgs.callPackages ../../../_sources/generated.nix {}).starship-nerd-font-symbols.src
                |> builtins.readFile
                |> builtins.fromTOML;
        };
    };
}
