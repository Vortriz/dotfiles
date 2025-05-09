{pkgs, ...}: {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ./cursor.nix
        ./hypridle.nix
        ./hyprlock.nix

        ./niri
        ./services
        ./sherlock
        ./waybar
        # keep-sorted end
    ];

    home.packages = with pkgs; [
        # keep-sorted start
        brightnessctl
        pavucontrol
        wl-clipboard
        xwayland-satellite
        # keep-sorted end
    ];
}
