{
    unify.home =
        {
            config,
            lib,
            pkgs,
            ...
        }:
        {
            programs.vicinae = {
                enable = true;
                systemd.enable = true;
            };

            home.packages = with pkgs; [ doi2bib3 ];

            xdg.dataFile = lib.attrsets.genAttrs' [ "doi2bib3" "dl" ] (
                name:
                lib.attrsets.nameValuePair "vicinae/scripts/${name}.fish" {
                    source = ../../scripts/${name}/script.fish;
                    executable = true;
                }
            );

            wayland.windowManager.niri.settings = {
                binds = {
                    "Alt+Space" = {
                        spawn-sh = "${lib.getExe config.programs.vicinae.package} toggle";
                        _props.hotkey-overlay-title = "Toggle Vicinae";
                    };
                    "Mod+V" = {
                        spawn-sh = "vicinae deeplink vicinae://launch/clipboard/history";
                        _props.hotkey-overlay-title = "Show Clipboard History";
                    };
                };

                layer-rule = [
                    {
                        match._props.namespace = "vicinae";

                        background-effect = {
                            blur = true;
                            xray = false;
                        };
                    }
                ];
            };
        };
}
