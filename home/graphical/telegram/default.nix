{
    config,
    pkgs,
    ...
}: {
    home.packages = [pkgs.telegram-desktop];

    xdg.mimeApps.defaultApplications = config.custom-lib.xdgAssociations "x-scheme-handler" "org.telegram.desktop.desktop" [
        "tg"
        "tonsite"
    ];
}
