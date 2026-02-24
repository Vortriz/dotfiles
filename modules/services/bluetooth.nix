{
    unify.nixos = {
        hardware.bluetooth = {
            enable = true;
            powerOnBoot = false;
        };

        services.blueman.enable = true;
    };
}
