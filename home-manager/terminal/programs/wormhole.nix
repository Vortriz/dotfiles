{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        magic-wormhole
    ];
}