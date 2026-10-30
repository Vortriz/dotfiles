{
    unify.home = { pkgs, ... }: {
        home.packages = with pkgs; [
            haruna
            ffmpeg-full
        ];

        xdg.mimeApps.defaultApplicationPackages = [ pkgs.haruna ];
    };
}
