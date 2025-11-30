{
    unify.nixos = {
        services = {
            asusd = {
                enable = true;
                enableUserService = true;
            };

            preload.enable = true;

            printing.enable = true;

            speechd.enable = false;
        };
    };
}
