{inputs, ...}: {
    unify.nixos = {
        config,
        pkgs,
        ...
    }: {
        nixpkgs.overlays = [inputs.nur-vortriz.overlays.fonts];

        fonts.packages = with pkgs;
            [
                # keep-sorted start block=yes
                (google-fonts.override {
                    fonts = [
                        "Inter"
                        "Overpass"
                        "Rubik"
                        "Hanken Grotesk"
                        "Open Sans"
                    ];
                })
                font-awesome
                maple-mono.variable
                nerd-fonts.fira-code
                nerd-fonts.jetbrains-mono
                roboto
                source-sans-pro
                # keep-sorted end
            ]
            # from nur
            ++ (with pkgs.fonts; [
                HelveticaNeueCyr
                SFMono-Nerd-Font-Ligaturized
            ])
            ++ [config.stylix.fonts.monospace.package];
    };
}
