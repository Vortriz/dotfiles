{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        swayidle
    ];

    services =
    let
        cmd = "${pkgs.swaylock-effects}/bin/swaylock -f -e --grace 3 --grace-no-mouse --grace-no-touch --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 5 --effect-blur 7x5 --effect-vignette 0.5:0.5";
    in {
        swayidle = {
            enable = true;
            events = [
                { event = "before-sleep"; command = cmd; }
                { event = "lock"; command = "lock"; }
            ];
            timeouts = [
                { timeout = 300; command = "${pkgs.niri}/bin/niri msg action power-off-monitors"; }
                { timeout = 360; command = cmd; }
                { timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend"; }
            ];
        };
    };

}