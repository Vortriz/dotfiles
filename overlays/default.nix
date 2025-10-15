_: {
    # This one brings our custom packages from the 'pkgs' directory
    additions = final: _prev: import ../pkgs final.pkgs;

    # You can change versions, add patches, set compilation flags, anything really.
    # https://nixos.wiki/wiki/Overlays
    modifications = _final: prev: {
        # keep-sorted start block=yes newline_separated=yes
        # https://discourse.nixos.org/t/request-for-libfprint-port-for-2808-a658/55474/32?u=vortriz
        fprintd = prev.fprintd.overrideAttrs (_: rec {
            version = "1.94.4";
            src = prev.pkgs.fetchFromGitLab {
                domain = "gitlab.freedesktop.org";
                owner = "libfprint";
                repo = "fprintd";
                rev = "refs/tags/v${version}}";
                hash = "sha256-B2g2d29jSER30OUqCkdk3+Hv5T3DA4SUKoyiqHb8FeU=";
            };
        });

        libfprint-focaltech-2808-a658 = prev.libfprint-focaltech-2808-a658.overrideAttrs (_: rec {
            version = "1.94.4";
            src = prev.pkgs.fetchurl {
                url = "https://github.com/Varrkan82/RTS5811-FT9366-fingerprint-linux-driver-with-VID-2808-and-PID-a658/raw/b040ccd953c27e26c1285c456b4264e70b36bc3f/libfprint-2-2-${version}+tod1-FT9366_20240627.x86_64.rpm";
                hash = "sha256-MRWHwBievAfTfQqjs1WGKBnht9cIDj9aYiT3YJ0/CUM=";
            };
        });
        # keep-sorted end
    };
}
