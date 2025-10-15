# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: let
    inherit (pkgs) callPackage;
    callPackage' = pkg: pkgs.callPackage pkg {sources = pkgs.callPackage ./sources/generated.nix {};};
in {
    HelveticaNeueCyr = callPackage ./fonts/HelveticaNeueCyr.nix {};
    SFMono = callPackage ./fonts/SFMono.nix {};

    swww-git = callPackage ./swww/package.nix {}; # remove when swww 0.10.4 is in nixpkgs
    xdg-desktop-portal-termfilechooser-git = callPackage' ./xdg-desktop-portal-termfilechooser-git/package.nix;
    dunefetch-git = callPackage' ./dunefetch-git/package.nix;
}
