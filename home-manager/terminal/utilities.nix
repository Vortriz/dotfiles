{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        devenv
        cachix
        nh

        imagemagick
        wl-clipboard
    ];

    programs = {
        direnv = {
            enable = true;
            # enableFishIntegration = true;
            nix-direnv.enable = true;
        };

        eza = {
            enable = true;
            icons = "auto";
        };

        starship = {
            enable = true;
            settings = (with builtins; fromTOML (
                readFile (
                    fetchurl {
                        url = "https://starship.rs/presets/toml/nerd-font-symbols.toml";
                        sha256 = "sha256:1bk2bb4nfwppg0gz4yyid4prdcf5r7yis0h4x10l8blvzlzm452g";
                    }
                )
            )) // {};
        };
    };
}