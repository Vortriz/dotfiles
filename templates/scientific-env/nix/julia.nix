{
    pkgs,
    cfg,
}:
pkgs.buildFHSEnv {
    targetPkgs = pkgs:
        (with pkgs; [
            cfg.julia.package
            xwayland-satellite # For X11 applications in Wayland
        ])
        ++ cfg.julia.extraPackages;

    extraOutputsToInstall = ["man" "dev"];

    name = "julia";

    profile = ''
        export DISPLAY=":0"
    '';

    runScript = cfg.shell + " -c 'julia'";
}
