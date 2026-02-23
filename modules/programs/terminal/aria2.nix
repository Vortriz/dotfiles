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
            home.packages = [pkgs.dl];

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

            wayland.windowManager.niri.settings.spawn-sh-at-startup = [
                ["${lib.getExe pkgs.aria2} --enable-rpc --rpc-listen-all"]
            ];
        };
    };
}
