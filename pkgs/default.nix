# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: let
    inherit (pkgs) callPackage;
    callPackage' = pkg: pkgs.callPackage pkg {sources = pkgs.callPackage ./sources/generated.nix {};};
in {
    HelveticaNeueCyr = callPackage ./fonts/HelveticaNeueCyr.nix {};
    SFMono = callPackage ./fonts/SFMono.nix {};

    xdg-desktop-portal-termfilechooser-custom = callPackage' ./xdg-desktop-portal-termfilechooser-custom/package.nix;
}
