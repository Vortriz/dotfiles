{
    unify.home = {hostConfig, ...}: let
        inherit (hostConfig.dirs) downloads;
    in {
        xdg = {
            enable = true;
            # For setting default applications
            mimeApps.enable = true;

            userDirs = {
                enable = true;

                download = downloads;
                pictures = "${downloads}/media";
                videos = "${downloads}/media";
            };
        };
    };
}
