{pkgs, ...}: {
    # image viewer
    home.packages = [pkgs.loupe];

    xdg.mimeApps.defaultApplications = let
        loupe = "org.gnome.Loupe.desktop";
    in {
        "image/jpeg" = loupe;
        "image/jpg" = loupe;
        "image/png" = loupe;
        "image/tiff" = loupe;
    };
}
