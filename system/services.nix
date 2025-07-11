{
    config,
    pkgs,
    ...
}: let
    inherit (config.var) username;
in {
    services = {
        # Auto mounting
        udisks2.enable = true;
        gvfs.enable = true;
        devmon.enable = true;

        # keep-sorted start block=yes newline_separated=yes
        # Asus laptop specific services
        asusd = {
            enable = true;
            enableUserService = true;
        };

        blueman.enable = true;

        fprintd = {
            enable = true;
            package = pkgs.fprintd.override {
                libfprint = pkgs.libfprint-focaltech-2808-a658;
            };
        };

        # Login manager
        logind = {
            powerKey = "suspend";
            powerKeyLongPress = "poweroff";
            lidSwitch = "suspend-then-hibernate";
        };

        # This setups a SSH server. Very important if you're setting up a headless system.
        openssh = {
            enable = true;

            settings = {
                AllowUsers = [username];
                # Opinionated: forbid root login through SSH.
                PermitRootLogin = "no";
                # Opinionated: use keys only.
                # Remove if you want to SSH using passwords
                PasswordAuthentication = false;
            };
        };

        # Sound
        pipewire = {
            enable = true;

            # ALSA is the raw audio interface exposed by Linux
            alsa.enable = true;
            alsa.support32Bit = true;

            # PulseAudio server emulation
            pulse.enable = true;

            # JACK is a more specialized sound server designed for audio production
            jack.enable = false;
        };

        # to prevent conflict with TLP
        power-profiles-daemon.enable = false;

        # Preload
        preload.enable = true;

        # Printing
        printing.enable = true;

        pulseaudio = {
            enable = false;
            package = pkgs.pulseaudioFull;
        };

        # TLP is a power management tool for Linux
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

        udev.packages = [pkgs.libfprint-focaltech-2808-a658];

        upower.enable = true;
        # keep-sorted end
    };
}
