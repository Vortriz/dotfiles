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
        quickshell.package = inputs.quickshell.packages.${pkgs.system}.default;

        niri = {
            enableKeybinds = true;
            enableSpawn = true;
        };
    };
}
