{
    pkgs,
    ...
}: {
    imports = [
        ./stylix
        ./hyprwm
        ./asusctl.nix
        ./bash.nix
        ./cli-utilities.nix
        ./fish.nix
        ./fonts.nix
        ./lmsensors.nix
        ./lsp.nix
        ./nix-ld.nix
        ./warp.nix
        ./wihotspot.nix
        ./zsh.nix
        # ./nbfc.nix
    ];
}