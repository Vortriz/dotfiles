{
    unify.home = {
        lib',
        pkgs,
        ...
    }: {
        home.packages = [pkgs.telegram-desktop];

        xdg.mimeApps.defaultApplications = lib'.xdgAssociations "x-scheme-handler" "org.telegram.desktop.desktop" [
            "tg"
            "tonsite"
        ];
    };
}
