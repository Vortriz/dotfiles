{
    config,
    inputs,
    lib,
    pkgs,
    ...
}: let
    qs = inputs.quickshell.packages.${pkgs.system}.default.overrideAttrs (prevAttrs: {
        nativeBuildInputs =
            prevAttrs.nativeBuildInputs
            ++ (with pkgs; [kdePackages.qt5compat]);
    });
in {
    home.packages =
        [
            qs
        ]
        ++ (with pkgs; [
            material-symbols
            cava
            wallust
            gpu-screen-recorder
        ])
        ++ (with pkgs.kdePackages; [
            qtmultimedia
            qtimageformats
            qtsvg
            syntax-highlighting
        ])
        ++ [pkgs.libsForQt5.qt5.qtgraphicaleffects];

    programs.niri.settings = {
        binds = let
            inherit (lib) getExe;
            inherit (config.niri-lib) run;

            # [TODO] OSD

            vol = cmd:
                (run {
                    cmd = "${getExe pkgs.pamixer} ${cmd}";
                })
                // {
                    allow-when-locked = true;
                };

            mute = cmd: _device:
                (run {
                    cmd = "${getExe pkgs.pamixer} -t${cmd}";
                })
                // {
                    allow-when-locked = true;
                };

            brightness = cmd:
                (run {
                    cmd = "${getExe pkgs.brightnessctl} set -e ${cmd}";
                })
                // {
                    allow-when-locked = true;
                };
        in {
            "XF86AudioRaiseVolume" = vol "-i 5";
            "XF86AudioLowerVolume" = vol "-d 5";

            "XF86AudioMute" = mute "" "Speaker";
            "XF86AudioMicMute" = mute " --default-source" "Mic";

            "XF86MonBrightnessUp" = brightness "+5%";
            "XF86MonBrightnessDown" = brightness "5%-";

            # "Mod+B" = run {
            #     cmd = "${getExe pkgs.ignis} toggle-window ignis_BAR_0";
            #     title = "Toggle Bar";
            # };
        };

        spawn-at-startup = [
            {command = [(lib.getExe qs)];}
        ];
    };
}
