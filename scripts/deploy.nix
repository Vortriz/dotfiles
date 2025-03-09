{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "deploy" {} ''
            echo "Rebuilding new generation..."
            ${pkgs.nh}/bin/nh os switch
            if test $status = 0
                cd $FLAKE

                set gen $(nixos-rebuild list-generations --flake $FLAKE | grep -oP "[0-9]*(?= current)")
                set prev_gen (math $gen - 1)
                set timestamp $(date '+%x %X')
                set branch $(git branch --show-current)

                echo -e "\n---\n\nGen $gen - $timestamp" >> $FLAKE/build.log
                ${pkgs.nvd}/bin/nvd diff /nix/var/nix/profiles/system-{$prev_gen,$gen}-link >> $FLAKE/build.log

                ${pkgs.git}/bin/git add -A
                ${pkgs.git}/bin/git commit -m "deployed $gen via $branch"
                cd -
            else
                echo "Failed to deploy!"
            end
        '')
    ];
}