{
    unify.home = {
        lib',
        pkgs,
        ...
    }: {
        home.packages = [pkgs.haruna];

        xdg.mimeApps.defaultApplications = lib'.xdgAssociations "video" "haruna" [
            # keep-sorted start
            "3gp"
            "avi"
            "flv"
            "m4v"
            "mkv"
            "mov"
            "mp4"
            "ogv"
            "ts"
            "webm"
            "wmv"
            # keep-sorted end
        ];
    };
}
