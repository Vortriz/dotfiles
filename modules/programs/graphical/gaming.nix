{
    unify.nixos = {
        programs.steam = {
            enable = true;
            gamescopeSession.enable = true;
        };

        programs.gamescope.enable = true;

        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };
    };
}
