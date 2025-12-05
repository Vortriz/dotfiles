{inputs, ...}: {
    perSystem = {
        config,
        pkgs,
        system,
        ...
    }: {
        devShells.default = pkgs.mkShell {
            inherit (config.pre-commit) shellHook;

            buildInputs = config.pre-commit.settings.enabledPackages;

            packages =
                (with pkgs; [
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
                    nvfetcher
                    ripgrep
                    # keep-sorted end
                ])
                ++ (with inputs; [
                    agenix.packages.${system}.default
                ]);
        };
    };
}
