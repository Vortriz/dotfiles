{inputs, ...}: {
    unify.nixos = {config, ...}: {
        imports = [
            inputs.silentSDDM.nixosModules.default
        ];

        programs.silentSDDM = let
            base = ../../assets;
            wallpaper = "34.png";

            font-family = config.stylix.fonts.monospace.name;
        in {
            enable = true;
            theme = "default";
            backgrounds.vortriz = base + /wallpapers/${wallpaper};
            profileIcons.vortriz = base + /profile.png;
            settings = {
                "General".scale = 1.5;
                "LoginScreen".background = wallpaper;
                "LockScreen".background = wallpaper;
                "LockScreen.Clock" = {
                    inherit font-family;
                    font-size = 128;

                    color = "#BFFFFFFF"; #ARGB
                    position = "center";
                };
                "LockScreen.Date" = {
                    inherit font-family;
                    font-size = 16;

                    format = "dddd, MMMM dd";
                };
                "LockScreen.Message".display = false;
                "LoginScreen.LoginArea.Username" = {
                    inherit font-family;
                };
                "LoginScreen.LoginArea.Spinner" = {
                    inherit font-family;
                };
            };
        };

        # [MARK] disabled fingerprint auth for now
        # for the life of me, i can't figure out how to make the delay go away
        security.pam.services.login.fprintAuth = false;
    };
}
