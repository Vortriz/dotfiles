{
    unify.nixos = {pkgs, ...}: {
        boot = {
            plymouth = {
                enable = true;
                theme = "nixos";
                themePackages = [pkgs.nixos-boot-plymouth-theme];
            };

            # max resolution so that loader graphics look good
            # (RIP boot entry chooser)
            loader.systemd-boot.consoleMode = "max";

            # Required for Plymouth to work properly
            initrd.systemd.enable = true;

            # Enable "Silent boot"
            consoleLogLevel = 3;
            initrd.verbose = false;

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
