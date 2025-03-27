{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.callPackage ./battery.nix {})
        (pkgs.callPackage ./dl.nix {})
        (pkgs.callPackage ./oimg.nix {})
    ];
}
