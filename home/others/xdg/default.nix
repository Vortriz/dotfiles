{
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) downloadsDir;
    inherit (osConfig.defaults) file-manager terminal;
in {
    xdg = {
        enable = true;
        # For setting default applications
        mimeApps.enable = true;

        userDirs = {
            enable = true;

            download = downloadsDir;
            pictures = "${downloadsDir}/media";
            videos = "${downloadsDir}/media";
        };

        # Portals
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
                # keep-sorted start
                xdg-desktop-portal-gtk
                xdg-desktop-portal-termfilechooser-git
                xdg-desktop-portal-wlr
                # keep-sorted end
            ];
        };

        configFile."xdg-desktop-portal-termfilechooser/config".text = ''
            [filechooser]
            cmd=${pkgs.xdg-desktop-portal-termfilechooser-git}/share/xdg-desktop-portal-termfilechooser/${lib.getName file-manager}-wrapper.sh
            default_dir=$HOME
            env=TERMCMD=${lib.getName terminal}
        '';
    };
}
