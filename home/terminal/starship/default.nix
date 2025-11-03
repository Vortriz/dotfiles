{pkgs, ...}: {
    programs.starship = {
        enable = true;

        settings =
            (pkgs.callPackages ../../sources/generated.nix {}).starship-nerd-font-symbols.src
            |> builtins.readFile
            |> builtins.fromTOML;
    };
}
