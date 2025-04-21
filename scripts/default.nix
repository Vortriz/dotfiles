{pkgs, ...}: {
    home.packages = [
        # keep-sorted start
        (pkgs.callPackage ./battery.nix {})
        (pkgs.callPackage ./dl.nix {})
        (pkgs.callPackage ./oimg.nix {})
        # keep-sorted end
    ];
}
