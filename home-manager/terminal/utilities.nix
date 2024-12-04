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
                        sha256 = "sha256:1ka72sz61hk60b2pxrcgxz23cvyaz49sscdj9mzz4ffd3jrcsjzn";
                    }
                )
            )) // {};
        };
    };
}