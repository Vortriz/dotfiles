{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            haruna
            celluloid
            ffmpeg-full
        ];

        xdg.mimeApps.defaultApplicationPackages = [pkgs.haruna];
    };
}
