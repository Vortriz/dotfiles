{
    config,
    inputs,
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) username;
in {
    imports = [inputs.niri-shell.homeModules.default];

    programs.niri-shell.enable = true;

    programs.niri.settings = {
        binds = let
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

            "Mod+B" = run {
                cmd = "${getExe pkgs.ignis} toggle-window ignis_BAR_0";
                title = "Toggle Bar";
            };
        };

        spawn-at-startup = [
            {command = [(lib.getExe pkgs.ignis) "init" "-c" "/home/${username}/ignis/config.py"];}
        ];
    };
}
