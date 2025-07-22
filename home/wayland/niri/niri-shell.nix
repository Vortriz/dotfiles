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
        spawn-at-startup = [
            {command = [(lib.getExe qs)];}
        ];

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

            "Alt+Space" = run {
                cmd = "${lib.getExe qs} ipc call globalIPC toggleRunner";
                title = "Open application launcher";
            };

            "Mod+B" = run {
                cmd = "${getExe qs} ipc call bar toggleBar";
                title = "Toggle Bar";
            };
        };
    };
}
