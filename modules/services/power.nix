{
    unify.nixos = {
        lib,
        pkgs,
        ...
    }: {
        services = {
            power-profiles-daemon.enable = false; # to prevent conflict with TLP

            upower = {
                enable = true;
                percentageAction = 3;
            };

            tlp = {
                enable = true;

                settings = {
                    RESTORE_THRESHOLDS_ON_BAT = 1;
                    START_CHARGE_THRESH_BAT0 = 75;
                    STOP_CHARGE_THRESH_BAT0 = 80;

                    PLATFORM_PROFILE_ON_AC = "performance";
                    PLATFORM_PROFILE_ON_BAT = "balanced";

                    CPU_DRIVER_OPMODE_ON_AC = "passive";
                    CPU_DRIVER_OPMODE_ON_BAT = "passive";

                    CPU_BOOST_ON_AC = 1;
                    CPU_BOOST_ON_BAT = 0;
                    CPU_SCALING_GOVERNOR_ON_AC = "performance";
                    CPU_SCALING_GOVERNOR_ON_BAT = "balanced";
                    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
                    CPU_ENERGY_PERF_POLICY_ON_BAT = "balanced";
                };
            };

            # Login manager
            logind.settings.Login = {
                HandlePowerKey = "suspend";
                HandlePowerKeyLongPress = "poweroff";
                HandleLidSwitch = "suspend-then-hibernate";
            };
        };

        systemd.user.services.batteryd = {
            enable = true;
            wantedBy = ["graphical-session.target"];
            serviceConfig = {
                Restart = "on-failure";
                RestartSec = 5;
                ExecStart = lib.getExe pkgs.batteryd;
            };
        };
    };
}
