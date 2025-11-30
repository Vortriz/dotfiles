{
    unify.hosts.nixos.sagittarius = {
        nixos = {
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
        };
    };
}
