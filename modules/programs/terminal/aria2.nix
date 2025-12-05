{
    unify = {
        nixos = {hostConfig, ...}: {
            users.users.${hostConfig.username}.extraGroups = ["aria2"];
        };

        home = {
            config,
            lib,
            pkgs,
            ...
        }: {
            home.packages = [pkgs.nur.repos.Vortriz.dl];

            programs.aria2 = {
                enable = true;

                settings = {
                    # keep-sorted start
                    console-log-level = "warn";
                    dir = "${config.xdg.cacheHome}/dl";
                    max-concurrent-downloads = 4;
                    max-connection-per-server = 8;
                    split = 8;
                    # keep-sorted end
                };
            };

            programs.niri.settings.spawn-at-startup = [
                {command = [(lib.getExe pkgs.aria2) "--enable-rpc" "--rpc-listen-all"];}
            ];
        };
    };
}
