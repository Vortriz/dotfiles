{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "lockoff" {} ''
            ${pkgs.swaylock-effects}/bin/swaylock -f -e --grace 3 --grace-no-mouse --grace-no-touch --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 5 --effect-blur 7x5 --effect-vignette 0.5:0.5
        '')
    ];
}