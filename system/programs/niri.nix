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
    };

    niri-flake.cache.enable = false;

    services.displayManager.gdm.enable = true;
}
