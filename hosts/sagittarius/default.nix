{
    inputs,
    config,
    ...
}: {
    unify.hosts.nixos.sagittarius = {
        users.vortriz.modules = config.unify.hosts.nixos.sagittarius.modules;

        nixos = {
            config,
            pkgs,
            ...
        }: let
            fprintPkg = pkgs.nur.repos.Vortriz.libfprint-focaltech-2808-a658-alt;
        in {
            imports = [
                inputs.nixos-hardware.nixosModules.common-cpu-intel
            ];

            nixpkgs.hostPlatform = {system = "x86_64-linux";};

            boot = {
                loader = {
                    systemd-boot = {
                        enable = true;
                        configurationLimit = 4;
                    };

                    efi.canTouchEfiVariables = true;
                };

                supportedFilesystems = ["ntfs"];

                initrd = {
                    availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "usbhid" "sd_mod"];
                    kernelModules = [];
                };

                kernelPackages = pkgs.linuxPackages_latest;
                kernelModules = ["kvm-intel" "acpi_call"];
                extraModulePackages = with config.boot.kernelPackages; [acpi_call];

                extraModprobeConfig = ''
                    options xe force_probe=9a60
                    options i915 force_probe=!9a60
                '';
            };

            networking = {
                hostName = "sagittarius";
                networkmanager.enable = true;
                firewall.enable = true;
            };

            hardware = {
                enableAllFirmware = true;
                cpu.intel.updateMicrocode = true;
                intelgpu.driver = "xe";
            };

            services = {
                fprintd = {
                    enable = false;
                    package = pkgs.nur.repos.Vortriz.fprintd.override {
                        libfprint = fprintPkg;
                    };
                };
                udev.packages = [fprintPkg];
            };
        };
    };
}
