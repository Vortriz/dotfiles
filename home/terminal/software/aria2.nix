{
    programs.aria2 = {
        enable = true;

        settings = {
            dir = "/mnt/SECONDARY/downloads/.tmp"; # TODO: global vars
            max-concurrent-downloads = 4;
            split = 8;
            max-connection-per-server = 8;
            console-log-level = "warn";
        };
    };
}