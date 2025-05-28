{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        android-tools
        just
        magic-wormhole
        ookla-speedtest
        pandoc
        rclone
        # keep-sorted end
    ];
}
