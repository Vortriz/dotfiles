# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
    HelveticaNeueCyr = pkgs.callPackage ./fonts/HelveticaNeueCyr.nix {};
    SFMono = pkgs.callPackage ./fonts/SFMono.nix {};

    xdg-desktop-portal-termfilechooser-custom = pkgs.callPackage ./xdg-desktop-portal-termfilechooser-custom.nix {};

    niriswitcher = pkgs.python3Packages.callPackage ./niriswitcher.nix {};
}
