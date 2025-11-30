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

            # env = {
            #     NIXOS_CONFIG = self.nixosConfigurations.nixos.config.var.dotfiles;
            # };

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
                    nom
                    nvfetcher
                    ripgrep
                    # keep-sorted end
                ])
                ++ (with inputs; [
                    # keep-sorted start
                    agenix.packages.${system}.default
                    # keep-sorted end
                ]);
        };
    };
}
