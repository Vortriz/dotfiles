{
    programs.sherlock.settings.launchers = [
        # keep-sorted start block=yes newline_separated=yes
        {
            name = "App Launcher";
            type = "app_launcher";
            alias = "app";
            args = {};
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
            name = "Clipboard";
            type = "clipboard-execution";
            args = {
                capabilities = ["url" "colors.all"];
            };
            priority = 1;
            home = true;
        }

        {
            name = "Cloudflare Warp";
            type = "command";
            alias = "w";
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
            name = "Emoji Picker";
            type = "emoji_picker";
            alias = "emoji";
            args = {};
            priority = 4;
            home = false;
        }

        {
            name = "Power Management";
            type = "command";
            alias = ":";
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
        # keep-sorted end
    ];
}
