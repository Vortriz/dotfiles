{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            # keep-sorted start
            android-tools
            brightnessctl
            fzf
            just
            libnotify
            magic-wormhole
            ookla-speedtest
            ouch
            pandoc
            rclone
            s-tui
            trash-cli
            wl-clipboard
            # keep-sorted end
        ];
    };
}
