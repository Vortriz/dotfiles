{pkgs, ...}: {
    imports = [
        ./niri
        ./services
        ./sherlock
        ./waybar

        ./cursor.nix
        ./hypridle.nix
        ./hyprlock.nix
    ];

    home.packages = with pkgs; [
        brightnessctl
        pavucontrol
    ];
}
