{
    unify.home = {
        config,
        lib,
        pkgs,
        ...
    }: let
        xdp-termfilechooser = pkgs.xdg-desktop-portal-termfilechooser;
    in {
        programs.yazi = {
            enable = true;

            initLua = ./init.lua;

            shellWrapperName = "y";
        };

        stylix.targets.yazi.enable = true;

        home.packages = [pkgs.exiftool];

        wayland.windowManager.niri.settings.binds."Mod+E" = {
            spawn-sh = "xdg-terminal-exec --app-id=yazi ${lib.getExe config.programs.yazi.finalPackage}";
            _props.hotkey-overlay-title = "Launch Yazi";
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
                env=TERMCMD=kitty
            '';
        };
    };
}
