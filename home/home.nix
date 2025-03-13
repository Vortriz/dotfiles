# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
    inputs,
    outputs,
    ...
}: {
    # You can import other home-manager modules here
    imports = [
        # If you want to use modules your own flake exports (from modules/home-manager):
        # outputs.homeManagerModules.example

        # Or modules exported from other flakes (such as nix-colors):
        # inputs.nix-colors.homeManagerModules.default
        inputs.scientific-fhs.nixosModules.default
        inputs.misumisumi-dotfiles.homeManagerModules.zotero

        # You can also split up your configuration and import pieces of it here:
        ./services
        ./software
        ./terminal
        ./stylix.nix

        ../scripts
    ];

    nixpkgs = {
        # You can add overlays here
        overlays = [
            # Add overlays your own flake exports (from overlays and pkgs dir):
            outputs.overlays.additions
            outputs.overlays.modifications

            # You can also add overlays exported from other flakes:
            # neovim-nightly-overlay.overlays.default
            inputs.yazi.overlays.default

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
        username = "vortriz";
        homeDirectory = "/home/vortriz";
    };

    # Enable home-manager
    programs.home-manager.enable = true;

    systemd.user = {
        # Nicely reload system units when changing configs
        startServices = "sd-switch";
    };

    # Default applications
    xdg.mimeApps = {
        enable = true;

        defaultApplications = {
            "image/png" = "org.nomacs.ImageLounge.desktop";
            "image/jpg" = "org.nomacs.ImageLounge.desktop";
            "image/jpeg" = "org.nomacs.ImageLounge.desktop";
            "application/pdf" = "sioyek.desktop";
            "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
            "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
}
