{
    unify.home = {
        lib',
        pkgs,
        ...
    }: {
        # image viewer
        home.packages = [pkgs.loupe];

        xdg.mimeApps.defaultApplications = lib'.xdgAssociations "image" "org.gnome.Loupe.desktop" [
            # keep-sorted start
            "avif"
            "bmp"
            "gif"
            "heic"
            "heif"
            "ico"
            "jpeg"
            "jpg"
            "png"
            "svg"
            "tif"
            "tiff"
            "webp"
            # keep-sorted end
        ];
    };
}
