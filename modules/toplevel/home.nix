{
    unify = {
        nixos =
            {
                config,
                hostConfig,
                ...
            }:
            {
                _module.args.homeConfig = config.home-manager.users.${hostConfig.username};
                home-manager = {
                    useUserPackages = true;
                    useGlobalPkgs = true;
                    backupFileExtension = "backup";
                };
            };

        home =
            { hostConfig, ... }:
            {
                programs.home-manager.enable = true;
                manual.manpages.enable = false;

                home = {
                    inherit (hostConfig) username;
                    homeDirectory = "/home/" + hostConfig.username;
                };

                # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
                home.stateVersion = "26.05";
            };
    };
}
