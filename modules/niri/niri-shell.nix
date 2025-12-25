{inputs, ...}: {
    unify = {
        nixos = {
            nixpkgs.overlays = [
                inputs.quickshell.overlays.default
            ];

            # to use dms-greet
            systemd.user.services.niri-flake-polkit.enable = true;

            services.displayManager.gdm.enable = true;
        };

        home = {pkgs, ...}: {
            imports = [
                inputs.niri-shell.homeModules.dank-material-shell
                inputs.niri-shell.homeModules.niri
            ];

            programs.dank-material-shell = {
                enable = true;

                niri = {
                    enableKeybinds = true;
                };

                systemd.enable = true;
            };

            programs.niri.settings.layer-rules = [
                {
                    matches = [{namespace = "dms:blurwallpaper";}];
                    place-within-backdrop = true;
                }
            ];

            # [TODO] test if this works
            home.packages = with pkgs; [
                wl-mirror
            ];
        };
    };
}
