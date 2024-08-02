{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        youtube-music
    ];
}