{pkgs, ...}: {
    # image viewer
    home.packages = [pkgs.nomacs];

    xdg.mimeApps.defaultApplications = {
        # keep-sorted start
        "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
        "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
        # keep-sorted end
    };
}
