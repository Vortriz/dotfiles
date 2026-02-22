{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            # keep-sorted start
            android-tools
            brightnessctl
            fzf
            just
            magic-wormhole
            ookla-speedtest
            ouch
            pandoc
            rclone
            s-tui
            surge
            trash-cli
            wl-clipboard
            # keep-sorted end
        ];
    };
}
