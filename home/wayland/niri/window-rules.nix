[
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
            {app-id = "firefox";}
            {app-id = "code";}
            {app-id = "obsidian";}
            {title = ".*pdf";}
            {app-id = "yazi";}
            {app-id = "mpv";}
            {app-id = "Zotero";}
        ];

        open-maximized = true;
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
        matches = [
            {title = ".*pdf";}
            {app-id = "kitty";}
        ];

        default-column-display = "tabbed";
        # TODO: auto-tabbing
    }
    {
        matches = [
            {app-id = "obsidian";}
            {app-id = "com.github.th_ch.youtube_music";}
        ];

        scroll-factor = 0.6;
    }
    {
        matches = [
            {app-id = "it.catboy.ripdrag";}
        ];

        open-floating = true;
        focus-ring = {
            width = 4;
            active.color = "#85e89d";
        };
    }
]
