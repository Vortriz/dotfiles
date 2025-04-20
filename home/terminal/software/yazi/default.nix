{
    imports = [
        ./plugins.nix
    ];

    programs.yazi = {
        enable = true;

        initLua = ./init.lua;
        keymap = import ./keymap.nix;
        settings = import ./settings.nix;

        shellWrapperName = "y";
    };

    stylix.targets.yazi.enable = true;
}
