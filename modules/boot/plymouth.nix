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

            # Kernel parameters for clean boot
            kernelParams = [
                "quiet"
                "splash"
                "plymouth.ignore-serial-consoles"
            ];
        };
    };
}
