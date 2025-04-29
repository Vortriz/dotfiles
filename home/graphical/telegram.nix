{pkgs, ...}: {
    home.packages = [pkgs.telegram-desktop];

    xdg.mimeApps.defaultApplications = let
        telegram = "org.telegram.desktop.desktop";
    in {
        "x-scheme-handler/tg" = telegram;
        "x-scheme-handler/tonsite" = telegram;
    };
}
