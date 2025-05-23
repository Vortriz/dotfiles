# Generate with `nixos-generate-config`
{
    config,
    lib,
    modulesPath,
    pkgs,
    ...
}: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot = {
        initrd = {
            availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "usbhid" "sd_mod"];
            kernelModules = [];
        };

        kernelModules = ["kvm-intel" "acpi_call"];
        extraModulePackages = with config.boot.kernelPackages; [acpi_call];
        supportedFilesystems = ["ntfs"];

        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 5;
            };

            efi.canTouchEfiVariables = true;
        };

        kernelPackages = pkgs.linuxPackages_latest;
    };

    fileSystems."/" = {
        device = "/dev/disk/by-label/ROOT";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-label/SYSTEM";
        fsType = "vfat";
    };

    fileSystems."/mnt/HOUSE" = {
        device = "/dev/disk/by-label/HOUSE";
        fsType = "btrfs";
        options = ["rw"];
    };

    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 16 * 1024;
        }
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
