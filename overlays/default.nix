_: {
    # This one brings our custom packages from the 'pkgs' directory
    additions = final: _prev: import ../pkgs final.pkgs;

    # You can change versions, add patches, set compilation flags, anything really.
    # https://nixos.wiki/wiki/Overlays
    modifications = _final: prev: {
        flameshot = prev.flameshot.overrideAttrs (_old: {
            src = prev.pkgs.fetchFromGitHub {
                owner = "flameshot-org";
                repo = "flameshot";
                rev = "63a4ab669bba83bdde878963df80a3c4e9331e21";
                sha256 = "1axif6lfc35f10150dlq1k0l3j4ssvj02vg72lvwk99mxs41cg7q";
            };
            cmakeFlags = ["-DUSE_WAYLAND_GRIM=true" "-DUSE_WAYLAND_CLIPBOARD=true"];
        });
    };
}
