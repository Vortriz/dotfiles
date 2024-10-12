{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "deploy" {} ''
            echo "Rebuilding new generation..."
            nh os switch
            if test $status = 0
                set gen $(nixos-rebuild list-generations --flake $FLAKE | grep -oP "[0-9]*(?= current)")
                set timestamp $(date '+%x %X')
                echo "$gen - $timestamp" >> $FLAKE/build.log
                git add *
                git commit -m "deployed $gen"
            else
                echo "Failed to deploy!"
            end
        '')
    ];
}