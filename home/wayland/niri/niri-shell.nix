{inputs, ...}: {
    imports = [inputs.niri-shell.homeModules.dankMaterialShell];

    programs.dankMaterialShell = {
        enable = true;
        enableKeybinds = true;
        enableSpawn = true;
    };
}
