{
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
        keymap = import ./keymap.nix {inherit osConfig;};
        settings = import ./settings.nix;

        shellWrapperName = "y";
    };

    stylix.targets.yazi.enable = true;

    home.packages = with pkgs; [
        exiftool
    ];
}
