{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        neofetch
        unzip
        p7zip
        rar
    ];
}