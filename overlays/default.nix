_: {
    # This one brings our custom packages from the 'pkgs' directory
    additions = final: _prev: import ../pkgs final.pkgs;

    # You can change versions, add patches, set compilation flags, anything really.
    # https://nixos.wiki/wiki/Overlays
    modifications = _final: prev: {
        # keep-sorted start block=yes newline_separated=yes
        flameshot = prev.flameshot.overrideAttrs (_old: {
            src = prev.pkgs.fetchFromGitHub {
                owner = "flameshot-org";
                repo = "flameshot";
                rev = "63a4ab669bba83bdde878963df80a3c4e9331e21";
                sha256 = "1axif6lfc35f10150dlq1k0l3j4ssvj02vg72lvwk99mxs41cg7q";
            };
            cmakeFlags = ["-DUSE_WAYLAND_GRIM=true" "-DUSE_WAYLAND_CLIPBOARD=true"];
        });

        niriswitcher = prev.niriswitcher.overrideAttrs (_old: {
            src = prev.pkgs.fetchFromGitHub {
                owner = "isaksamsten";
                repo = "niriswitcher";
                rev = "de0ef44a6423776934434328fc5a38c61124176e";
                hash = "sha256-njEd9s432qlBeQSXRL5gDSIEgzF0qwceND09aGTRo0U=";
            };
        });
        # keep-sorted end
    };
}
