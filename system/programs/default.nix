{
    pkgs,
    ...
}: {
    imports = [
        ./asusctl.nix
        ./fonts.nix
        ./lmsensors.nix
        # ./nbfc.nix
        ./nix-ld.nix
        ./warp.nix
        ./wihotspot.nix
    ];
}