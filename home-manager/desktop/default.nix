{
    pkgs,
    ...
}: {
    imports = [
        ./anydesk.nix
        ./ventoy.nix
        ./wine.nix
    ];

    home.packages = with pkgs; [
    ];
}