{
    pkgs,
    inputs,
    ...
}: {
    imports = [
        ./niri
        ./waybar

        ./hypridle.nix
        ./hyprlock.nix
    ];

    home.packages = with pkgs; [
        brightnessctl
        inputs.ulauncher.packages."${pkgs.system}".default
        pavucontrol
    ];
}