{inputs, ...}: {
    unify = {
        nixos = {
            nixpkgs.overlays = [
                inputs.quickshell.overlays.default
            ];
        };

        home = {pkgs, ...}: {
            imports = [
                inputs.niri-shell.homeModules.dankMaterialShell.default
                inputs.niri-shell.homeModules.dankMaterialShell.niri
            ];

            programs.dankMaterialShell = {
                enable = true;

                niri = {
                    enableKeybinds = true;
                    enableSpawn = true;
                };
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
