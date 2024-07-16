{
    pkgs,
    ...
}: {
    imports = [
        ./bluetooth.nix
        ./boot.nix
        ./graphics.nix
        ./locale.nix
        ./networking.nix
        ./security.nix
        ./storage-optimization.nix
        ./swap.nix
        ./time.nix
        ./virtualisation.nix
    ];
}