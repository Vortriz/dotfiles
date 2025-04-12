# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
    HelveticaNeueCyr = pkgs.callPackage ./fonts/HelveticaNeueCyr.nix {};
    SFMono = pkgs.callPackage ./fonts/SFMono.nix {};

    cosmic-ext-alternative-startup = pkgs.callPackage ./cosmic-ext-alternative-startup.nix {};
    cosmic-ext-niri = pkgs.callPackage ./cosmic-ext-niri.nix {};
}
