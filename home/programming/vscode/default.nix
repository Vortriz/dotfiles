{
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) monospaceFontName;
in {
    programs.vscode = {
        enable = true;

        mutableExtensionsDir = true;

        profiles.default = {
            enableUpdateCheck = false;
            enableExtensionUpdateCheck = false;

            userSettings = builtins.fromJSON (builtins.readFile (pkgs.substitute {
                src = ./settings.json;
                substitutions = ["--subst-var-by" "font-name" monospaceFontName];
            }));

            extensions = import ./extensions.nix {inherit pkgs;};
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
}
