# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
    osConfig,
    inputs,
    outputs,
    pkgs,
    ...
}: let
    username = osConfig.var.username;
in {
    # You can import other home-manager modules here
    imports = [
        # If you want to use modules your own flake exports (from modules/home-manager):
        # outputs.homeManagerModules.example

        # Or modules exported from other flakes (such as nix-colors):
        # inputs.nix-colors.homeManagerModules.default
        inputs.misumisumi-dotfiles.homeManagerModules.zotero
        inputs.scientific-fhs.nixosModules.default
        inputs.walker.homeManagerModules.default

        # You can also split up your configuration and import pieces of it here:
        ./graphical
        ./programming
        ./terminal
        ./wayland

        ../scripts

        ./stylix.nix
    ];

    nixpkgs = {
        # You can add overlays here
        overlays = [
            # Add overlays your own flake exports (from overlays and pkgs dir):
            outputs.overlays.additions
            outputs.overlays.modifications

            # You can also add overlays exported from other flakes:
            # neovim-nightly-overlay.overlays.default

            # Or define it inline, for example:
            # (final: prev: {
            #     hi = final.hello.overrideAttrs (oldAttrs: {
            #         patches = [ ./change-hello-to-hi.patch ];
            #     });
            # })
        ];
        # Configure your nixpkgs instance
        config = {
            # Disable if you don't want unfree packages
            allowUnfree = true;
        };
    };

    home = {
        username = username;
        homeDirectory = "/home/" + username;
    };

    # Enable home-manager
    programs.home-manager.enable = true;

    systemd.user = {
        # Nicely reload system units when changing configs
        startServices = "sd-switch";
    };

    # Default applications
    xdg = {
        mimeApps = {
            enable = true;

            defaultApplications = {
                "application/pdf" = "sioyek.desktop";
                "image/jpeg" = "org.nomacs.ImageLounge.desktop";
                "image/jpg" = "org.nomacs.ImageLounge.desktop";
                "image/png" = "org.nomacs.ImageLounge.desktop";
                "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
                "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
            };
        };

        # DO NOT EFFING TOUCH THIS
        portal = {
            enable = true;

            config = {
                niri = {
                    default = ["gnome" "gtk"];
                    "org.freedesktop.impl.portal.Access" = "gtk";
                    "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
                    "org.freedesktop.impl.portal.ScreenCast" = "wlr";
                    "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
                };
            };
            extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
                xdg-desktop-portal-termfilechooser
                xdg-desktop-portal-wlr
            ];
        };

        configFile."xdg-desktop-portal-termfilechooser/config".text = ''
            [filechooser]
            cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
            default_dir=$HOME
            env=TERMCMD=kitty
        '';
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
}
