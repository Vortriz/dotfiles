{
    pkgs,
    ...
}: let
    git = "${pkgs.git}/bin/git";
    nix = "${pkgs.nix}/bin/nix";
    fd = "${pkgs.fd}/bin/fd";
    unf = "${pkgs.update-nix-fetchgit}/bin/update-nix-fetchgit";

    update-script = pkgs.writers.writeFishBin "update" {} ''
        echo "Updating flake and git fetcher inputs..."
        cd $FLAKE
        ${nix} flake update && ${fd} .nix --exec ${unf}
        ${git} add -A
        ${git} commit -m "chore: update inputs"
        cd -
    '';
in {
    home.packages = [
        update-script
    ];
}