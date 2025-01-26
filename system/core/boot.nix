{
    pkgs,
    config,
    ...
}: {
    boot = {
        loader = {
            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 5;
            efi.canTouchEfiVariables = true;
        };

        kernelPackages = pkgs.linuxPackages_latest;
        extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
        kernelModules = [ "acpi_call" ];
    };
}