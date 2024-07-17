{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        devenv
        cachix
    ];
}