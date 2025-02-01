{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        mission-center
    ];
}