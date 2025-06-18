{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        brightnessctl
        pavucontrol
        wl-clipboard
        # keep-sorted end
    ];
}
