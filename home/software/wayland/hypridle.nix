{
    pkgs,
    ...
}: {
    services.hypridle = {
        enable = true;

        settings = {
            general = {
                ignore_dbus_inhibit = false;
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "${pkgs.niri}/bin/niri msg action power-on-monitors";
            };

            listener = [
                {
                    timeout = 180;
                    on-timeout = "loginctl lock-session";
                }
                {
                    timeout = 240;
                    on-timeout = "${pkgs.niri}/bin/niri msg action power-off-monitors";
                    on-resume = "${pkgs.niri}/bin/niri msg action power-on-monitors";
                }
                {
                    timeout = 600;
                    on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
                }
            ];

        };
    };
}
