{
    inputs,
    pkgs,
    ...
}: {
    imports = [inputs.niri-shell.homeModules.DankMaterialShell];

    programs.DankMaterialShell = {
        enable = true;
        enableKeybinds = true;
        enableSpawn = true;
    };

    home.packages = [pkgs.dgop-git];
}
