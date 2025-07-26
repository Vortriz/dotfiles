{pkgs, ...}: {
    home.packages = [pkgs.clapper];

    xdg.mimeApps.defaultApplications = let
        clapper = "com.github.rafostar.Clapper.desktop";
    in {
        "video/mp4" = clapper;
        "video/matroska" = clapper;
        "video/MP2T" = clapper;
        "video/msvideo" = clapper;
    };
}
