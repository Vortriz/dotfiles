{
    lib,
    osConfig,
    pkgs,
    ...
}: {
    programs.aria2 = {
        enable = true;

        settings = {
            # keep-sorted start
            console-log-level = "warn";
            dir = "${osConfig.var.downloadsDir}/.tmp";
            max-concurrent-downloads = 4;
            max-connection-per-server = 8;
            split = 8;
            # keep-sorted end
        };
    };

    programs.niri.settings.spawn-at-startup = [
        {command = [(lib.getExe pkgs.aria2) "--enable-rpc" "--rpc-listen-all"];}
    ];
}
