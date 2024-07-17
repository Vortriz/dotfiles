{
    pkgs,
    ...
}: {
    imports = [
        ./ventoy.nix
        ./wine.nix
    ];

    home.packages = with pkgs; [
    ];
}