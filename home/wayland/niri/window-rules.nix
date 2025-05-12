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
        open-maximized = true;

        matches = [
            {app-id = "firefox";}
            {app-id = "code";}
            {app-id = "obsidian";}
            {title = ".*pdf";}
            {app-id = "yazi";}
            {app-id = "celluloid";}
            {app-id = "Zotero";}
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
        default-column-display = "tabbed"; # TODO: auto-tabbing when it lands

        matches = [
            {title = ".*pdf";}
            {app-id = "kitty";}
        ];
    }
    {
        scroll-factor = 0.6;

        matches = [
            {app-id = "obsidian";}
            {app-id = "com.github.th_ch.youtube_music";}
        ];
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
            {app-id = "firefox";}
            {app-id = "com.github.th_ch.youtube_music";}
        ];
    }
    {
        open-on-workspace = "Code";
        open-focused = true;

        matches = [
            {app-id = "code";}
        ];
    }
]
