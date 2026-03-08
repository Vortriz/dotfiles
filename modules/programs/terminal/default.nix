{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            # keep-sorted start
            android-tools
            brightnessctl
            fzf
            gemini-cli
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
