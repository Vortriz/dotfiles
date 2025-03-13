{
    pkgs,
    ...
}: let
    jq = "${pkgs.jq}/bin/jq";

    np-script = pkgs.writers.writeFishBin "np" {} ''
        nix store prefetch-file --json $argv[1] | ${jq} -r .hash
    '';
in {
    home.packages = [
        np-script
    ];
}