{
    unify = {
        nixos = {
            environment.pathsToLink = [
                "/share/xdg-desktop-portal"
                "/share/applications"
            ];
        };

        home =
            {
                config,
                hostConfig,
                ...
            }:
            let
                inherit (hostConfig.dirs) downloads;
                inherit (config.xdg)
                    dataHome
                    configHome
                    cacheHome
                    stateHome
                    ;
            in
            {
                xdg = {
                    enable = true;
                    # For setting default applications
                    mimeApps.enable = true;

                    userDirs = {
                        enable = true;
                        setSessionVariables = true;

                        download = downloads;
                        pictures = "${downloads}/media";
                        videos = "${downloads}/media";
                    };
                };

                home = {
                    preferXdgDirectories = true;

                    sessionVariables = {
                        UV_CACHE_DIR = "${hostConfig.dirs.storage}/dev/.cache/uv";

                        CARGO_HOME = "${dataHome}/cargo";

                        NPM_CONFIG_INIT_MODULE = "${configHome}/npm/config/npm-init.js";
                        NPM_CONFIG_CACHE = "${cacheHome}/npm";
                        NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";

                        NODE_REPL_HISTORY = "${stateHome}/node_repl_history";

                        RUSTUP_HOME = "${dataHome}/rustup";

                        DOTNET_CLI_HOME = "${dataHome}/dotnet";

                        PYTHON_HISTORY = "${stateHome}/python_history";

                        HISTFILE = "${stateHome}/bash/history";

                        GNUPGHOME = "${dataHome}/gnupg";

                        COPILOT_HOME = "${configHome}/copilot";
                    };
                };
            };
    };
}
