{
    unify.nixos = {
        programs.steam = {
            enable = true;
            gamescopeSession.enable = true;
        };

        programs.gamescope.enable = true;

        hardware.graphics = {
            enable = true;

            # For steam (wine)
            enable32Bit = true;
        };
    };
}
