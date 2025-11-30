{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            # keep-sorted start
            android-tools
            brightnessctl
            ffmpeg-full
            fzf
            imagemagick
            just
            magic-wormhole
            nur.repos.Vortriz.dl
            ookla-speedtest
            ouch
            pandoc
            rclone
            trash-cli
            wl-clipboard
            # keep-sorted end
        ];
    };
}
