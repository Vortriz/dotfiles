{inputs, ...}: {
    unify = {
        nixos = {pkgs, ...}: {
            imports = [inputs.niri.nixosModules.default];
            nixpkgs.overlays = [inputs.niri.overlays.niri-nix];

            nix.settings = {
                substituters = ["https://niri-nix.cachix.org"];
                trusted-public-keys = ["niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="];
            };

            programs.niri = {
                enable = true;
                package = pkgs.niri-unstable;
            };
        };

        home = {pkgs, ...}: {
            imports = [inputs.niri.homeModules.default];

            wayland.windowManager.niri = {
                enable = true;
                package = pkgs.niri-unstable;
            };

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
