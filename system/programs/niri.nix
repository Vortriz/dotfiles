{
    inputs,
    pkgs,
    ...
}: {
    imports = [inputs.niri.nixosModules.niri];

    nixpkgs.overlays = [inputs.niri.overlays.niri];

    programs.niri = {
        enable = true;

        package = pkgs.niri-unstable;
        # package = pkgs.niri-unstable.override {src = inputs.niri-overview;};
    };

    niri-flake.cache.enable = true;
}
