{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        brightnessctl
        pavucontrol
        wl-clipboard
        xwayland-satellite
        # keep-sorted end
    ];
}
