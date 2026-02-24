{
    unify.home = {config, ...}: let
        inherit (config.lib.stylix) colors;
    in {
        wayland.windowManager.niri.settings.window-rule = [
            # general rules
            {
                clip-to-geometry = true;
                geometry-corner-radius = 12.0;
                draw-border-with-background = false;
            }
            {
                match._props.is-window-cast-target = true;

                focus-ring.off = [];
                border = {
                    on = [];
                    width = 2;
                    active-color = "#85e89d";
                };
                shadow = {
                    on = [];
                    color = "#85e89d70";
                };
            }

            # bulk window rules
            {
                open-maximized = true;

                _children = [
                    {match._props.app-id = "firefox";}
                    {match._props.app-id = "yazi";}
                    {match._props.app-id = "org.kde.haruna";}
                    {match._props.app-id = "Code";}
                    {match._props.app-id = "obsidian";}
                    {match._props.app-id = "sioyek";}
                    {match._props.app-id = "Zotero";}
                    {match._props.app-id = "dev.zed.Zed";}
                    {match._props.app-id = "vesktop";}
                    {match._props.app-id = "nix-search-tv";}
                    {match._props.app-id = "^libreoffice-.*$";}
                ];
            }
            {
                open-floating = true;
                border = {
                    on = [];
                    width = 2;
                    inactive-color = colors.withHashtag.base03;
                };
                shadow.on = [];

                _children = [
                    {match._props.app-id = "org.gnome.Calculator";}
                    {match._props.app-id = "it.catboy.ripdrag";}
                    {match._props.app-id = "zenity";}
                    {match._props.title = "System Monitor";}
                ];
            }
            {
                default-column-display = "tabbed";

                _children = [
                    {match._props.app-id = "kitty";}
                    {match._props.app-id = "sioyek";}
                ];
            }
            {
                scroll-factor = 0.4;

                _children = [
                    {match._props.app-id = "obsidian";}
                    {match._props.app-id = "com.github.th_ch.youtube_music";}
                    {match._props.app-id = "vesktop";}
                ];
            }

            # specific window rules
            {
                _children = [{match._props.title = "System Monitor";}];

                default-window-height.proportion = 0.6;
                default-column-width.proportion = 0.6;

                focus-ring.active-color = colors.withHashtag.base0E;
                border.active-color = colors.withHashtag.base0E;
            }
            {
                _children = [{match._props.app-id = "it.catboy.ripdrag";}];

                focus-ring.active-color = colors.withHashtag.base0F;
                border.active-color = colors.withHashtag.base0F;
            }
            {
                _children = [{match._props.app-id = "com.github.th_ch.youtube_music";}];

                default-column-width.proportion = 0.7;
                default-window-height.proportion = 0.7;
            }
            {
                _children = [{match._props.app-id = "Espanso.SyncTool";}];

                open-floating = true;
            }

            # workspace rules
            {
                open-on-workspace = "Acad";
                open-focused = true;

                _children = [
                    {match._props.app-id = "obsidian";}
                    {match._props.app-id = "sioyek";}
                    {match._props.app-id = "Zotero";}
                ];
            }
            {
                open-on-workspace = "Browse";
                open-focused = true;

                _children = [
                    {match._props.app-id = "firefox";}
                    {match._props.app-id = "com.github.th_ch.youtube_music";}
                    {match._props.app-id = "vesktop";}
                    {match._props.app-id = "org.telegram.desktop";}
                ];
            }
            {
                open-on-workspace = "Code";
                open-focused = true;

                _children = [
                    {match._props.app-id = "dev.zed.Zed";}
                    {match._props.app-id = "Code";}
                ];
            }
        ];
    };
}
