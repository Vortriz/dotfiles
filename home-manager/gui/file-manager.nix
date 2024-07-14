{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        deepin.dde-file-manager
    ];
}