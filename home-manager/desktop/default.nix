{
    pkgs,
    ...
}: {
    imports = [
        ./hyprwm
        ./anydesk.nix
        ./ventoy.nix
        ./wine.nix
    ];

    home.packages = with pkgs; [
    ];

    stylix.autoEnable = false;
}