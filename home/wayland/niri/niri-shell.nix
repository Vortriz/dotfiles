{inputs, ...}: {
    imports = [inputs.niri-shell.homeModules.default];

    programs.niri-shell.enable = true;
}
