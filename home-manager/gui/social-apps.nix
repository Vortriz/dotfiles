{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        discord
        telegram-desktop
    ];
}