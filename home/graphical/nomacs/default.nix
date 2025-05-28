{pkgs, ...}: {
    # image viewer
    home.packages = [pkgs.nomacs];

    xdg.mimeApps.defaultApplications = let
        nomacs = "org.nomacs.ImageLounge.desktop";
    in {
        "image/jpeg" = nomacs;
        "image/jpg" = nomacs;
        "image/png" = nomacs;
        "image/tiff" = nomacs;
    };
}
