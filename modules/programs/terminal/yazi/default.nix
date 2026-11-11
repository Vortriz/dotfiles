{
    unify.home =
        {
            config,
            lib,
            pkgs,
            ...
        }:
        let
            xdpt = pkgs.xdg-desktop-portal-termfilechooser;
            offc = pkgs.org-freedesktop-FileManager1-common;
        in
        {
            programs.yazi = {
                enable = true;

                initLua = ./init.lua;
                shellWrapperName = "y";
            };

            stylix.targets.yazi.enable = true;

            wayland.windowManager.niri.settings.binds."Mod+E" = {
                spawn-sh = "xdg-terminal-exec --app-id=yazi ${lib.getExe config.programs.yazi.finalPackage}";
                _props.hotkey-overlay-title = "Launch Yazi";
            };

            xdg = {
                portal = {
                    extraPortals = [ xdpt ];
                    config.niri."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
                };

                configFile."${xdpt.pname}/config".text = ''
                    [filechooser]
                    cmd=${xdpt}/share/${xdpt.pname}/yazi-wrapper.sh
                    default_dir=$HOME
                    env=TERMCMD=xdg-terminal-exec
                '';

                configFile."org.freedesktop.FileManager1.common/config".text = ''
                    cmd=${offc}/share/${offc.pname}/yazi-wrapper.sh
                    TERMCMD=xdg-terminal-exec
                '';
            };

            systemd.user.services.org-freedesktop-filemanager1-common = {
                Unit = {
                    Description = "Run a FileManager1 interface to launch yazi";
                    X-RestartIfChanged = true;
                };
                Install.WantedBy = [ "default.target" ];
                Service.ExecStart = "${offc}/libexec/file_manager_dbus";
            };
        };
}
