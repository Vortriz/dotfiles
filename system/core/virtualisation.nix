{
    virtualisation = {
        # following configuration is added only when building VM with build-vm
        vmVariant.virtualisation = {
            memorySize =  4096;
            cores = 4;
        };

        # for distrobox
        podman = {
            enable = true;

            dockerCompat = true;
        };
    };
}