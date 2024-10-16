{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeBashBin "lock" {} ''
            swaylock -f -e --fade-in 0.1 --grace 3 --grace-no-mouse --grace-no-touch --screenshots --clock --timestr "%H : %M" --datestr "%b %d, %a" --indicator --indicator-radius 100 --indicator-thickness 5 --effect-blur 7x5 --effect-vignette 0.5:0.5
        '')
    ];
}