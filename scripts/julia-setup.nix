{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "julia-setup" {} ''
            echo "Going to make a Julia development environment..."

            if test -d .git
                set git_repo "yes"
            end

            cp $FLAKE/templates/julia.nix ./flake.nix

            read -P "Add required packages in flake.nix and press Enter to proceed..."

            if test $git_repo = "yes"
                echo ".direnv" >> .gitignore
                ${pkgs.git}/bin/git add flake.nix .gitignore
            end

            echo "use flake" > .envrc
            direnv allow

            if test $git_repo = "yes"
                ${pkgs.git}/bin/git add .envrc
            end
        '')
    ];
}
