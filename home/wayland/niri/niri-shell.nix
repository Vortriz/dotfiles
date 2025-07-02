{
    config,
    inputs,
    lib,
    pkgs,
    ...
}: {
    imports = [inputs.niri-shell.homeModules.default];

    programs.niri-shell.enable = true;

    programs.niri.settings.binds = let
        inherit (lib) getExe;
        inherit (config.niri-lib) run;

        ignis = getExe config.programs.niri-shell.package;

        vol = cmd:
            (run {
                cmd = "${getExe pkgs.pamixer} ${cmd} && ${ignis} open-window ignis_OSD_Speaker";
            })
            // {
                allow-when-locked = true;
            };

        mute = cmd: device:
            (run {
                cmd = "${getExe pkgs.pamixer} -t${cmd} && ${ignis} open-window ignis_OSD_${device}";
            })
            // {
                allow-when-locked = true;
            };

        brightness = cmd:
            (run {
                cmd = "${getExe pkgs.brightnessctl} set -e ${cmd} && ${ignis} open-window ignis_OSD_Backlight";
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
    };
}
