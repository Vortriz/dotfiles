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
        quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

        niri = {
            enableKeybinds = true;
            enableSpawn = true;
        };
    };

    programs.niri.settings.layer-rules = [
        {
            matches = [{namespace = "dms:blurwallpaper";}];
            place-within-backdrop = true;
        }
    ];

    # [TODO] test if this works
    home.packages = with pkgs; [
        wl-mirror
    ];
}
