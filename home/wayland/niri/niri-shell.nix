{
    inputs,
    pkgs,
    ...
}: {
    imports = [
        inputs.niri-shell.homeModules.dankMaterialShell.default
        inputs.niri-shell.homeModules.dankMaterialShell.niri
    ];

    programs.dankMaterialShell = {
        enable = true;
        quickshell.package = inputs.niri-shell.packages.${pkgs.system}.quickshell;

        niri = {
            enableKeybinds = true;
            enableSpawn = true;
        };

        plugins = let
            official = inputs.niri-shell.inputs.dms-plugins;
        in {
            DankBatteryAlerts.src = "${official}/DankBatteryAlerts";
        };
    };
}
