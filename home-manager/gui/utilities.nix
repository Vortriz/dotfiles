{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        gnome-calculator
        filelight
    ];
}