{ inputs, ... }: {
    unify.nixos =
        {
            config,
            pkgs,
            ...
        }:
        {
            fonts.packages =
                with pkgs;
                [
                    # keep-sorted start block=yes
                    corefonts
                    font-awesome
                    hanken-grotesk
                    inter
                    maple-mono.variable
                    nerd-fonts.fira-code
                    nerd-fonts.jetbrains-mono
                    open-sans
                    overpass
                    roboto
                    rubik
                    source-sans-pro
                    # keep-sorted end
                ]
                # from nur
                ++ (with inputs.vpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.fonts; [
                    HelveticaNeueCyr
                    SFMono-Nerd-Font-Ligaturized
                ])
                ++ [ config.stylix.fonts.monospace.package ];
        };
}
