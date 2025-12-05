{
    unify.nixos = {
        services = {
            asusd = {
                enable = true;
                enableUserService = true;
            };

            printing.enable = true;

            speechd.enable = false;
        };
    };
}
