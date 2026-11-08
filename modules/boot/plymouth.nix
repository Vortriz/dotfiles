{ inputs, ... }: {
    unify.nixos = { pkgs, ... }: {
        boot = {
            plymouth = {
                enable = true;
                theme = "nixos-loading-spin";
                themePackages = [
                    inputs.nixos-plymouth.packages.${pkgs.stdenv.hostPlatform.system}.nixos-loading-spin
                ];
            };

            # max resolution so that loader graphics look good
            # (RIP boot entry chooser)
            loader.systemd-boot.consoleMode = "max";

            # Enable "Silent boot"
            consoleLogLevel = 3;

            # Kernel parameters for clean boot
            kernelParams = [
                "quiet"
                "systemd.show_status=auto"
                "splash"
                "plymouth.ignore-serial-consoles"
                # "plymouth.enable=0" "disablehooks=plymouth"
                # "plymouth.debug"
            ];

            loader.timeout = 0;
        };
    };
}
