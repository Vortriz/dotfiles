{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        ventoy-full
    ];
}