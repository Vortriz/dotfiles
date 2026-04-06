{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            telegram-desktop
        ];

        programs.vesktop = {
            enable = true;

            settings = {
                checkUpdates = false;
                minimizeToTray = false;
                tray = false;
            };
            vencord.settings = {
                autoUpdate = false;
                autoUpdateNotification = false;
            };
        };
    };
}
