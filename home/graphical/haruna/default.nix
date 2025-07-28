{pkgs, ...}: {
    home.packages = [pkgs.haruna];

    xdg.mimeApps.defaultApplications = let
        haruna = "org.kde.haruna.desktop";
    in {
        "video/mp4" = haruna;
        "video/matroska" = haruna;
        "video/MP2T" = haruna;
        "video/msvideo" = haruna;
    };
}
