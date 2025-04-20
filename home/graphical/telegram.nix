{pkgs, ...}: {
    home.packages = [pkgs.telegram-desktop];

    xdg.mimeApps.defaultApplications = {
        "image/jpeg" = "org.nomacs.ImageLounge.desktop";
        "image/jpg" = "org.nomacs.ImageLounge.desktop";
        "image/png" = "org.nomacs.ImageLounge.desktop";
    };
}
