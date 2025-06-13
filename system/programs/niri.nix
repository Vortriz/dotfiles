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

    niri-flake.cache.enable = true;

    services.xserver.displayManager.gdm.enable = true;
}
