{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "julia-setup" {} ''
            echo "Going to make a Julia development environment..."

            cp $FLAKE/templates/julia.nix ./flake.nix

            read -P "Add required packages in flake.nix and press Enter to proceed..."

            echo "use flake" > .envrc
            direnv allow
        '')
    ];
}
