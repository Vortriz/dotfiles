{
    unify.home = {
        lib',
        pkgs,
        ...
    }: {
        home.packages = with pkgs; [
            telegram-desktop
            vesktop
        ];

        xdg.mimeApps.defaultApplications = lib'.xdgAssociations "x-scheme-handler" "org.telegram.desktop.desktop" [
            "tg"
            "tonsite"
        ];
    };
}
