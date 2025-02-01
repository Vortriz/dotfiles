{
    pkgs,
    inputs,
    ...
}: {
    imports = [
        ./niri
        ./waybar

        ./fuzzel.nix
        ./swayidle.nix
        ./swaylock.nix
    ];

    home.packages = with pkgs; [
        inputs.ulauncher.packages."${pkgs.system}".default
        brightnessctl
        pavucontrol
    ];
}