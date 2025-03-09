{
    programs.aria2 = {
        enable = true;

        settings = {
            dir = "/home/vortriz/downloads";
            max-concurrent-downloads = 4;
            split = 8;
            max-connection-per-server = 8;
        };
    };
}