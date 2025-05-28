{pkgs, ...}: {
    home.packages = [pkgs.celluloid];

    xdg.mimeApps.defaultApplications = let
        celluloid = "io.github.celluloid_player.Celluloid.desktop";
    in {
        "video/mp4" = celluloid;
        "video/matroska" = celluloid;
        "video/MP2T" = celluloid;
        "video/msvideo" = celluloid;
    };
}
