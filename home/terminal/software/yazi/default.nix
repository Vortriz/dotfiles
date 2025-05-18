{
    lib,
    osConfig,
    pkgs,
    ...
}: {
    imports = [
        ./plugins.nix
    ];

    programs.yazi = {
        enable = true;

        initLua = ./init.lua;
        keymap = import ./keymap.nix {inherit lib osConfig;};
        settings = import ./settings.nix {inherit lib osConfig;};

        shellWrapperName = "y";
    };

    stylix.targets.yazi.enable = true;

    home.packages = with pkgs; [
        exiftool
    ];
}
