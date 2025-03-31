{
    imports = [
        ./settings.nix
        ./keymap.nix
        ./plugins.nix
    ];

    programs.yazi = {
        enable = true;

        shellWrapperName = "y";
        initLua = ./init.lua;
    };

    stylix.targets.yazi.enable = true;
}
