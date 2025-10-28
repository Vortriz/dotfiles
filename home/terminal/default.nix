{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        android-tools
        ffmpeg-full
        imagemagick
        just
        magic-wormhole
        ookla-speedtest
        ouch
        pandoc
        rclone
        trash-cli
        # keep-sorted end
    ];
}
