{osConfig, ...}: let
    inherit (osConfig.var) downloadsDir;
in {
    programs.aria2 = {
        enable = true;

        settings = {
            dir = "${downloadsDir}/.tmp";
            max-concurrent-downloads = 4;
            split = 8;
            max-connection-per-server = 8;
            console-log-level = "warn";
        };
    };
}
