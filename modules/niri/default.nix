{inputs, ...}: {
    # [MARK] fix everything after https://github.com/sodiboo/niri-flake/pull/1548 is merged
    unify = {
        nixos = {pkgs, ...}: {
            imports = [inputs.niri.nixosModules.niri];
            nixpkgs.overlays = [inputs.niri.overlays.niri];

            programs.niri = {
                enable = true;
                package = pkgs.niri-unstable;
            };

            niri-flake.cache.enable = false;
        };

        home = {pkgs, ...}: {
            xdg.portal = {
                enable = true;
                config.niri = {
                    default = ["gnome" "gtk"];
                    "org.freedesktop.impl.portal.Access" = "gtk";
                    "org.freedesktop.impl.portal.ScreenCast" = "gnome";
                    "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
                };

                extraPortals = with pkgs; [
                    xdg-desktop-portal-gnome
                    xdg-desktop-portal-gtk
                ];
            };
        };
    };
}
