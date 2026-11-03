{
    unify = {
        nixos = {
            nixpkgs.overlays = [
                (_: prev: {
                    obsidian = prev.obsidian.overrideAttrs (old: {
                        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.makeWrapper ];
                        postFixup = (old.postFixup or "") + ''
                            wrapProgram $out/bin/obsidian \
                              --add-flags "--password-store=gnome-libsecret"
                        '';
                    });
                })
            ];
        };

        home = { pkgs, ... }: {
            home.packages = [ pkgs.obsidian ];
        };
    };
}
