{pkgs, ...}: {
    xdg = {
        portal = {
            enable = true;

            config.niri = {
                default = ["gnome" "gtk"];
                "org.freedesktop.impl.portal.Access" = "gtk";
                "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
                "org.freedesktop.impl.portal.ScreenCast" = "wlr";
                "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
            };

            extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
                xdg-desktop-portal-termfilechooser-custom
                xdg-desktop-portal-wlr
            ];
        };

        configFile."xdg-desktop-portal-termfilechooser/config".text = ''
            [filechooser]
            cmd=${pkgs.xdg-desktop-portal-termfilechooser-custom}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
            default_dir=$HOME
            env=TERMCMD=kitty
        '';
    };
}
