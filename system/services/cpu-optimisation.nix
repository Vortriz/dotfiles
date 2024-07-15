{
    services = {
        cpupower-gui.enable = false;

        # to prevent conflict with TLP
        power-profiles-daemon.enable = false;

        tlp = {
            enable = true;
            settings = {
                RESTORE_THRESHOLDS_ON_BAT = 1;
                START_CHARGE_THRESH_BAT0=75;
                STOP_CHARGE_THRESH_BAT0=80;

                PLATFORM_PROFILE_ON_AC = "performance";
                PLATFORM_PROFILE_ON_BAT = "performance";

                CPU_DRIVER_OPMODE_ON_AC = "passive";
                CPU_DRIVER_OPMODE_ON_BAT = "passive";

                CPU_BOOST_ON_AC = 1;
                CPU_BOOST_ON_BAT = 0;
                CPU_SCALING_GOVERNOR_ON_AC = "performance";
                CPU_SCALING_GOVERNOR_ON_BAT = "performance";
                CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
                CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
            };
        };
    };
}