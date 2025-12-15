{
    unify.home = {pkgs, ...}: {
        # image viewer
        home.packages = with pkgs; [
            loupe
            imagemagick
        ];

        xdg.mimeApps.defaultApplicationPackages = [pkgs.loupe];
    };
}
