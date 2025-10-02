_: {
    # This one brings our custom packages from the 'pkgs' directory
    additions = final: _prev: import ../pkgs final.pkgs;

    # You can change versions, add patches, set compilation flags, anything really.
    # https://nixos.wiki/wiki/Overlays
    modifications = _final: prev: {
        # keep-sorted start block=yes newline_separated=yes
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
