{
    inputs,
    pkgs,
    ...
}: {
    imports = [
        ./niri
        ./services
        ./walker
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
