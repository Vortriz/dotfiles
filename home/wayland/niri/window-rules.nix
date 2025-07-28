{
    config,
    lib,
    osConfig,
    ...
}: let
    inherit (lib) getName;
    inherit (osConfig.defaults) browser file-manager terminal;
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
                {app-id = getName browser;}
                {app-id = getName file-manager;}
                {app-id = "org.kde.haruna";}
                {app-id = "code";}
                {app-id = "obsidian";}
                {title = ".*pdf";}
                {app-id = "Zotero";}
                {app-id = "dev.zed.Zed";}
                {app-id = "vesktop";}
                {app-id = "nix-search-tv";}
                {app-id = ''libreoffice-(calc|draw|impress|math|writer)'';}
            ];
        }
        {
            open-floating = true;
            border = {
                enable = true;
                width = 2;
                inactive.color = config.lib.stylix.colors.withHashtag.base03;
            };
            shadow.enable = true;

            matches = [
                {app-id = "io.missioncenter.MissionCenter";}
                {app-id = "org.gnome.Calculator";}
                {app-id = "it.catboy.ripdrag";}
                {app-id = "it.mijorus.smile";}
            ];
        }
        {
            default-column-display = "tabbed";

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
            matches = [{app-id = "it.mijorus.smile";}];

            focus-ring.active.color = colors.withHashtag.base0A;
            border.active.color = colors.withHashtag.base0A;
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
                {app-id = "vesktop";}
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
    ];
}
