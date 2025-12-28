{
    unify = {
        nixos = {
            config,
            hostConfig,
            ...
        }: {
            _module.args.homeConfig = config.home-manager.users.${hostConfig.username};
            home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
            };
        };

        home = {
            config,
            hostConfig,
            lib,
            ...
        }: let
            inherit (config.xdg) dataHome configHome cacheHome;
        in {
            # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
            programs.home-manager.enable = true;

            home = {
                inherit (hostConfig) username;
                homeDirectory = "/home/" + hostConfig.username;
            };

            home = {
                sessionVariables = {
                    # Set uv cache directory
                    UV_CACHE_DIR = "${hostConfig.dirs.storage}/dev/.cache/uv";

                    CARGO_HOME = "${dataHome}/cargo";

                    GTK2_RC_FILES = lib.mkForce "${configHome}/gtk-2.0/gtkrc";

                    NPM_CONFIG_INIT_MODULE = "${configHome}/npm/config/npm-init.js";
                    NPM_CONFIG_CACHE = "${cacheHome}/npm";
                    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";

                    RUSTUP_HOME = "${dataHome}/rustup";
                };

                stateVersion = "25.11";
            };
        };
    };
}
