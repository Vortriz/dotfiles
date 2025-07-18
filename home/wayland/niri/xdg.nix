{pkgs, ...}: {
    xdg.portal = {
        config.niri = {
            default = ["gnome" "gtk"];
            "org.freedesktop.impl.portal.Access" = "gtk";
            "org.freedesktop.impl.portal.ScreenCast" = "gnome";
            "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };

        extraPortals = with pkgs; [
            # keep-sorted start
            xdg-desktop-portal-gnome
            xdg-desktop-portal-gtk
            # keep-sorted end
        ];
    };
}
