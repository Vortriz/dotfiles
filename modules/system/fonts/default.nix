{ pkgs, ... }:

{
    fonts.packages = with pkgs; [
        (callPackage ./HelveticaNeueCyr.nix { })
        (callPackage ./Inter.nix { })
        (callPackage ./Overpass.nix { })
        (callPackage ./Rubik.nix { })
        (callPackage ./SFMono.nix { })
        (nerdfonts.override { fonts = [ "JetBrainsMono"]; })
    ];
}