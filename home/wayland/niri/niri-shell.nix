{
    inputs,
    pkgs,
    ...
}: {
    imports = [inputs.niri-shell.homeModules.dankMaterialShell];

    programs.dankMaterialShell = {
        enable = true;
        quickshell.package = inputs.niri-shell.packages.${pkgs.system}.quickshell;

        enableKeybinds = true;
        enableSpawn = true;
    };
}
