{
    unify.home = {
        config,
        pkgs,
        ...
    }: {
        programs.vscode = {
            enable = true;

            mutableExtensionsDir = true;

            profiles.default = {
                enableUpdateCheck = false;
                enableExtensionUpdateCheck = false;

                userSettings =
                    pkgs.substitute {
                        src = ./settings.json;
                        substitutions = [
                            "--subst-var-by"
                            "font-name"
                            config.stylix.fonts.monospace.name
                            "--subst-var-by"
                            "shell"
                            "fish"
                        ];
                    }
                    |> builtins.readFile
                    |> builtins.fromJSON;
            };
        };

        home.file.".vscode/argv.json".text = builtins.toJSON {
            enable-crash-reporter = false;
            password-store = "gnome-libsecret";
        };

        stylix.targets.vscode = {
            enable = true;
            profileNames = ["default"];
        };
    };
}
