{ inputs, ... }: {
    perSystem =
        {
            config,
            pkgs,
            ...
        }:
        {
            devShells.default = pkgs.mkShell {
                inherit (config.pre-commit) shellHook;

                buildInputs = config.pre-commit.settings.enabledPackages;

                packages =
                    with pkgs;
                    [
                        # keep-sorted start
                        dix
                        fd
                        fish
                        git
                        jaq
                        just
                        micro
                        nh
                        nix-init
                        nix-melt
                        nix-prefetch-git
                        nix-prefetch-github
                        ripgrep
                        # keep-sorted end
                    ]
                    ++ [ inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.default ];

                TACK_NIX_CONF_TOKENS = 1;
            };
        };
}
