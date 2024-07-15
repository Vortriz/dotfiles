{
    pkgs,
    ...
}: {
    imports = [
        ./asus.nix
        ./cpu-optimisation.nix
        ./kde.nix
        ./pipewire.nix
        ./preload.nix
        ./printing.nix
        ./sddm.nix
        ./ssh.nix
        ./x11.nix
    ];
}