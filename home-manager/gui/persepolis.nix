{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        persepolis
    ];
}