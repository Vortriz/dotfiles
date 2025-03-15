{
    pkgs,
    inputs,
    ...
}: {
    imports = [
        ./niri
        ./waybar

        ./cursor.nix
        ./hypridle.nix
        ./hyprlock.nix
    ];

    home.packages = with pkgs; [
        brightnessctl
        inputs.ulauncher.packages."${pkgs.system}".default
        pavucontrol
    ];
}