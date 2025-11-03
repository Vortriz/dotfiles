{
    config,
    lib,
    pkgs,
    osConfig,
    ...
}: let
    inherit (osConfig.defaults) terminal;

    yazi = config.programs.yazi.finalPackage;
    xdp-termfilechooser = pkgs.nur.repos.Vortriz.xdg-desktop-portal-termfilechooser-git;
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

    home.packages = [pkgs.exiftool];

    programs.niri.settings.binds."Mod+E" = config.niri-lib.open-tui {
        app = lib.getExe yazi;
        app-id = lib.getName yazi;
    };

    xdg = {
        portal = {
            extraPortals = [xdp-termfilechooser];

            config.niri."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        };

        configFile."xdg-desktop-portal-termfilechooser/config".text = ''
            [filechooser]
            cmd=${xdp-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
            default_dir=$HOME
            env=TERMCMD=${lib.getName terminal}
        '';
    };
}
