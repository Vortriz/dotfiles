{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        nomacs
    ];
}