{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        filelight
    ];
}