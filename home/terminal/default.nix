{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        android-tools
        ffmpeg-full
        imagemagick
        just
        magic-wormhole
        nur.repos.Vortriz.dl
        ookla-speedtest
        ouch
        pandoc
        rclone
        trash-cli
        # keep-sorted end
    ];
}
