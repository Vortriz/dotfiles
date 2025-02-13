{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "deploy" {} ''
            echo "Rebuilding new generation..."
            nh os switch
            if test $status = 0
                cd $FLAKE
                set gen $(nixos-rebuild list-generations --flake $FLAKE | grep -oP "[0-9]*(?= current)")
                set timestamp $(date '+%x %X')
                set branch $(git branch --show-current)
                echo "$gen - $timestamp" >> $FLAKE/build.log
                git add -A
                git commit -m "deployed $gen through $branch"
                cd -
            else
                echo "Failed to deploy!"
            end
        '')
    ];
}