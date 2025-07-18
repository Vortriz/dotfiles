{osConfig, ...}: let
    inherit (osConfig.var) downloadsDir;
in {
    xdg = {
        enable = true;
        # For setting default applications
        mimeApps.enable = true;

        userDirs = {
            enable = true;

            download = downloadsDir;
            pictures = "${downloadsDir}/media";
            videos = "${downloadsDir}/media";
        };

        portal.enable = true;
    };
}
