{pkgs, ...}: {
    programs.niri = {
        enable = true;

        package = pkgs.niri-unstable;
        # package = pkgs.niri-unstable.override {src = inputs.niri-overview;};
    };

    niri-flake.cache.enable = true;
}
