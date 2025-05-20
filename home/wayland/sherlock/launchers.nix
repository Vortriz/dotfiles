[
    {
        name = "Clipboard";
        type = "clipboard-execution";
        args = {
            capabilities = ["url" "colors.all"];
        };
        priority = 1;
        home = true;
    }
    {
        name = "Calculator";
        type = "calculation";
        args = {
            capabilities = ["calc.math" "calc.units"];
        };
        priority = 1;
    }
    {
        name = "App Launcher";
        alias = "app";
        type = "app_launcher";
        args = {};
        priority = 1;
        home = true;
    }
    {
        name = "Cloudflare Warp";
        alias = "w";
        type = "command";
        args = {
            commands = {
                "Connect Warp" = {
                    exec = "warp-cli connect";
                    search_string = "connect";
                };
                "Disconnect Warp" = {
                    exec = "warp-cli disconnect";
                    search_string = "disconnect";
                };
            };
        };
        priority = 4;
    }
    {
        name = "Power Management";
        alias = ":";
        type = "command";
        args = {
            commands = {
                Shutdown = {
                    icon = "system-shutdown";
                    exec = "systemctl poweroff";
                    search_string = "poweroff;shutdown";
                };
                Sleep = {
                    icon = "system-suspend";
                    exec = "systemctl hybrid-sleep";
                    search_string = "sleep";
                };
                Reboot = {
                    icon = "system-reboot";
                    exec = "systemctl reboot";
                    search_string = "reboot";
                };
            };
        };
        priority = 4;
    }
]
