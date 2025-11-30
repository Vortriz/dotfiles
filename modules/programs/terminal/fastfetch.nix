{
    unify.home = {pkgs, ...}: {
        programs.fastfetch = {
            enable = true;
            settings = {
                "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
                logo = {
                    type = "builtin";
                    height = 15;
                    width = 30;
                    padding = {
                        top = 3;
                        left = 3;
                    };
                };
                modules = [
                    "break"
                    {
                        type = "custom";
                        format = "┌─────────────────Hardware─────────────────┐";
                        keyColor = "#61686C";
                    }
                    {
                        type = "host";
                        format = "ASUS Vivobook K3402ZA_S3402ZA";
                        key = " PC";
                        keyColor = "green";
                    }
                    {
                        type = "cpu";
                        format = "i5-12500H ({cores-physical}C/{cores-logical}T) @ {freq-max}";
                        key = "│ ├";
                        keyColor = "green";
                    }
                    {
                        type = "gpu";
                        format = "Iris Xe [{type}]";
                        key = "└ ├󰍛";
                        keyColor = "green";
                    }
                    {
                        type = "custom";
                        format = "└──────────────────────────────────────────┘";
                        keyColor = "#61686C";
                    }
                    "break"
                    {
                        type = "custom";
                        format = "┌─────────────────Software─────────────────┐";
                        keyColor = "#61686C";
                    }
                    {
                        type = "os";
                        key = " OS";
                        keyColor = "yellow";
                    }
                    {
                        type = "kernel";
                        key = "│ ├";
                        keyColor = "yellow";
                    }
                    {
                        type = "packages";
                        key = "│ ├󰏖";
                        keyColor = "yellow";
                    }
                    {
                        type = "shell";
                        format = "{pretty-name} {version}";
                        key = "└ └";
                        keyColor = "yellow";
                    }
                    "break"
                    {
                        type = "wm";
                        key = " WM";
                        keyColor = "blue";
                    }
                    {
                        type = "terminal";
                        key = "│ └";
                        keyColor = "blue";
                    }
                    {
                        type = "terminalfont";
                        format = "{name}";
                        key = "└ └";
                        keyColor = "blue";
                    }
                    {
                        type = "custom";
                        format = "└──────────────────────────────────────────┘";
                        keyColor = "#61686C";
                    }
                    "break"
                    {
                        type = "custom";
                        format = "┌──────────────Uptime / Age────────────────┐";
                        keyColor = "#61686C";
                    }
                    {
                        type = "command";
                        key = "⏱ OS Age ";
                        keyColor = "magenta";
                        text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
                    }
                    {
                        type = "uptime";
                        key = "  Uptime ";
                        keyColor = "magenta";
                    }
                    {
                        type = "custom";
                        format = "└──────────────────────────────────────────┘";
                        keyColor = "#61686C";
                    }
                    "break"
                    "colors"
                ];
            };
        };

        home.packages = [pkgs.nur.repos.Vortriz.dunefetch];
    };
}
