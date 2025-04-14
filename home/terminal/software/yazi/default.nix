{
    imports = [
        ./keymap.nix
        ./plugins.nix
        ./settings.nix
    ];

    programs.yazi = {
        enable = true;

        shellWrapperName = "y";
        initLua = ./init.lua;
    };

    stylix.targets.yazi.enable = true;
}
