# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
    HelveticaNeueCyr = pkgs.callPackage ./fonts/HelveticaNeueCyr.nix {};
    SFMono = pkgs.callPackage ./fonts/SFMono.nix {};
}
