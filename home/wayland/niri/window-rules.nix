{
    lib,
    osConfig,
    ...
}: let
    inherit (lib) getName;
    inherit (osConfig.defaults) browser file-manager terminal video-player;
in {
    programs.niri.settings.window-rules = [
        {
            clip-to-geometry = true;
            geometry-corner-radius = let
                r = 12.0;
            in {
                top-left = r;
                top-right = r;
                bottom-left = r;
                bottom-right = r;
            };
        }
        {
            matches = [
                {is-window-cast-target = true;}
            ];

            focus-ring.enable = false;

            border = {
                enable = true;
                width = 2;
                active.color = "#85e89d";
            };

            shadow = {
                enable = true;
                color = "#85e89d70";
            };
        }
        {
            open-maximized = true;

            matches = [
                {app-id = getName browser;}
                {app-id = getName file-manager;}
                {app-id = getName video-player;}
                {app-id = "code";}
                {app-id = "obsidian";}
                {title = ".*pdf";}
                {app-id = "Zotero";}
                {app-id = "dev.zed.Zed";}
                {app-id = "vesktop";}
                {app-id = "nix-search-tv";}
            ];
        }
        {
            matches = [
                {app-id = "io.missioncenter.MissionCenter";}
            ];

            open-floating = true;
            shadow.enable = true;
            default-window-height.proportion = 0.6;
            default-column-width.proportion = 0.75;

            focus-ring = {
                width = 4;
                active.color = "#f38ba8";
                inactive.color = "#ebebeb";
            };
        }
        {
            matches = [
                {app-id = "org.gnome.Calculator";}
            ];

            open-floating = true;
            shadow.enable = true;
        }
        {
            default-column-display = "tabbed"; # [TODO] auto-tabbing when it lands

            matches = [
                {app-id = getName terminal;}
                {title = ".*pdf";}
            ];
        }
        {
            scroll-factor = 0.4;

            matches = [
                {app-id = "obsidian";}
                {app-id = "com.github.th_ch.youtube_music";}
                {app-id = "vesktop";}
            ];
        }
        {
            matches = [
                {app-id = "it.catboy.ripdrag";}
                {app-id = "it.mijorus.smile";}
            ];

            open-floating = true;
            focus-ring = {
                width = 4;
                active.color = "#85e89d";
            };
        }
        {
            open-on-workspace = "Acad";
            open-focused = true;

            matches = [
                {app-id = "obsidian";}
                {title = ".*pdf";}
                {app-id = "Zotero";}
            ];
        }
        {
            open-on-workspace = "Browse";
            open-focused = true;

            matches = [
                {app-id = getName browser;}
                {app-id = "com.github.th_ch.youtube_music";}
            ];
        }
        {
            open-on-workspace = "Code";
            open-focused = true;

            matches = [
                {app-id = "dev.zed.Zed";}
                {app-id = "code";}
            ];
        }
        {
            matches = [
                {app-id = "com.github.th_ch.youtube_music";}
            ];

            default-column-width.proportion = 0.7;
            default-window-height.proportion = 0.7;
        }
    ];
}
