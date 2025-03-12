{
    pkgs,
    ...
}: let
    git = "${pkgs.git}/bin/git";
    nh = "${pkgs.nh}/bin/nh";
    nvd = "${pkgs.nvd}/bin/nvd";

    deploy-script = pkgs.writers.writeFishBin "deploy" {} ''
        echo "Rebuilding new generation..."
        ${nh} os switch
        if test $status = 0
            cd $FLAKE

            set gen $(nixos-rebuild list-generations --flake $FLAKE | grep -oP "[0-9]*(?= current)")
            set prev_gen (math $gen - 1)
            set timestamp $(date '+%x %X')
            set branch $(${git} branch --show-current)

            echo -e "\n---\n\nGen $gen - $timestamp" >> $FLAKE/build.log
            ${nvd} diff /nix/var/nix/profiles/system-{$prev_gen,$gen}-link >> $FLAKE/build.log

            ${git} add -A
            ${git} commit -m "deployed $gen via $branch"
            cd -
        else
            echo "Failed to deploy!"
        end
    '';
in {
    home.packages = [
        deploy-script
    ];
}