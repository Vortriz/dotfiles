{ inputs, ... }: {
    unify.nixos = { pkgs, ... }: {
        boot = {
            plymouth = {
                enable = false;
                theme = "nixos-loading-spin";
                themePackages = [
                    inputs.nixos-plymouth.packages.${pkgs.stdenv.hostPlatform.system}.nixos-loading-spin
                ];
                extraConfig = ''
                    [Daemon]
                    DeviceScale=an-integer-scaling-factor
                '';
            };

            # max resolution so that loader graphics look good
            # (RIP boot entry chooser)
            loader.systemd-boot.consoleMode = "max";

            # Enable "Silent boot"
            consoleLogLevel = 3;

            # Kernel parameters for clean boot
            kernelParams = [
                "quiet"
                "splash"
                "rd.udev.log_level=3"
                "rd.systemd.show_status=auto"
            ];

            loader.timeout = 0;
        };
    };
}
