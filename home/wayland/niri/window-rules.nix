{
    config,
    lib,
    osConfig,
    ...
}: let
    inherit (config.lib.stylix) colors;
in {
    programs.niri.settings.window-rules = [
        # general rules
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

        # bulk window rules
        {
            open-maximized = true;

            matches = [
                {app-id = "firefox";}
                {app-id = "yazi";}
                {app-id = "org.kde.haruna";}
                {app-id = "Code";}
                {app-id = "obsidian";}
                {app-id = "sioyek";}
                {app-id = "Zotero";}
                {app-id = "dev.zed.Zed";}
                {app-id = "vesktop";}
                {app-id = "nix-search-tv";}
                {app-id = "^libreoffice-.*$";}
            ];
        }
        {
            open-floating = true;
            border = {
                enable = true;
                width = 2;
                inactive.color = colors.withHashtag.base03;
            };
            shadow.enable = true;

            matches = [
                {app-id = "io.missioncenter.MissionCenter";}
                {app-id = "org.gnome.Calculator";}
                {app-id = "it.catboy.ripdrag";}
            ];
        }
        {
            default-column-display = "tabbed";

            matches = [
                {app-id = lib.getName osConfig.defaults.terminal;}
                {app-id = "sioyek";}
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

        # specific window rules
        {
            matches = [{app-id = "io.missioncenter.MissionCenter";}];

            default-window-height.proportion = 0.6;
            default-column-width.proportion = 0.75;

            focus-ring.active.color = colors.withHashtag.base0E;
            border.active.color = colors.withHashtag.base0E;
        }
        {
            matches = [{app-id = "it.catboy.ripdrag";}];

            focus-ring.active.color = colors.withHashtag.base0F;
            border.active.color = colors.withHashtag.base0F;
        }
        {
            matches = [{app-id = "com.github.th_ch.youtube_music";}];

            default-column-width.proportion = 0.7;
            default-window-height.proportion = 0.7;
        }

        # workspace rules
        {
            open-on-workspace = "Acad";
            open-focused = true;

            matches = [
                {app-id = "obsidian";}
                {app-id = "sioyek";}
                {app-id = "Zotero";}
            ];
        }
        {
            open-on-workspace = "Browse";
            open-focused = true;

            matches = [
                {app-id = "firefox";}
                {app-id = "com.github.th_ch.youtube_music";}
                {app-id = "vesktop";}
                {app-id = "org.telegram.desktop";}
            ];
        }
        {
            open-on-workspace = "Code";
            open-focused = true;

            matches = [
                {app-id = "dev.zed.Zed";}
                {app-id = "Code";}
            ];
        }
    ];
}
