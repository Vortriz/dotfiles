{
    inputs,
    pkgs,
    ...
}: {
    imports = [
        ./niri
        ./services
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
