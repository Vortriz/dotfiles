{
    inputs,
    config,
    ...
}:
{
    unify.hosts.nixos.sagittarius = {
        users.vortriz.modules = config.unify.hosts.nixos.sagittarius.modules;

        nixos =
            {
                config,
                pkgs,
                ...
            }:
            let
                libfprintPkg = pkgs.libfprint-focaltech-2808-a658;
            in
            {
                imports = [
                    inputs.nixos-hardware.nixosModules.common-cpu-intel
                ];

                nixpkgs.overlays = [
                    (_self: super: {
                        fprintd = super.fprintd.overrideAttrs {
                            version = "1.94.4";
                            src = pkgs.fetchFromGitLab {
                                domain = "gitlab.freedesktop.org";
                                owner = "libfprint";
                                repo = "fprintd";
                                rev = "refs/tags/v1.94.4}";
                                hash = "sha256-B2g2d29jSER30OUqCkdk3+Hv5T3DA4SUKoyiqHb8FeU=";
                            };
                        };
                    })
                ];

                nixpkgs.hostPlatform = {
                    system = "x86_64-linux";
                };

                boot = {
                    loader = {
                        systemd-boot = {
                            enable = true;
                            configurationLimit = 4;
                        };

                        efi.canTouchEfiVariables = true;
                    };

                    supportedFilesystems = [ "ntfs" ];

                    initrd = {
                        availableKernelModules = [
                            "xhci_pci"
                            "thunderbolt"
                            "vmd"
                            "nvme"
                            "usb_storage"
                            "usbhid"
                            "sd_mod"
                        ];
                        kernelModules = [ ];
                    };

                    kernelPackages = pkgs.linuxPackages_latest;
                    kernelModules = [
                        "kvm-intel"
                        "acpi_call"
                    ];
                    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

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

                nix.settings.system-features = [ "gccarch-alderlake" ];

                services = {
                    fprintd = {
                        enable = true;
                        package = pkgs.fprintd.override {
                            libfprint = libfprintPkg;
                        };
                    };
                    udev.packages = [ libfprintPkg ];
                };
            };
    };
}
