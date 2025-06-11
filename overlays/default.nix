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

        # https://discourse.nixos.org/t/request-for-libfprint-port-for-2808-a658/55474/32?u=vortriz
        fprintd = prev.fprintd.overrideAttrs (_old: rec {
            version = "1.94.4";
            src = prev.pkgs.fetchFromGitLab {
                domain = "gitlab.freedesktop.org";
                owner = "libfprint";
                repo = "fprintd";
                rev = "refs/tags/v${version}}";
                hash = "sha256-B2g2d29jSER30OUqCkdk3+Hv5T3DA4SUKoyiqHb8FeU=";
            };
        });
        # keep-sorted end
    };
}
