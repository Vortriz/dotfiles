{
    config,
    lib,
    pkgs,
    osConfig,
    ...
}: let
    inherit (osConfig.defaults) file-manager;
in {
    imports = [
        ./keymap.nix
        ./plugins.nix
        ./settings.nix
    ];

    programs.yazi = {
        enable = true;

        initLua = ./init.lua;

        shellWrapperName = "y";
    };

    stylix.targets.yazi.enable = true;

    home.packages = with pkgs; [
        exiftool
    ];

    programs.niri.settings.binds."Mod+E" = config.niri-lib.open-tui {
        app = lib.getExe file-manager;
        app-id = lib.getName file-manager;
    };
}
