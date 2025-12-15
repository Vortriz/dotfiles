{inputs, ...}: {
    unify.home = {
        programs.starship = {
            enable = true;

            settings =
                inputs.starship-nerd-font-symbols
                |> builtins.readFile
                |> builtins.fromTOML;
        };
    };
}
