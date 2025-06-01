{
    pkgs,
    cfg,
}:
pkgs.buildFHSEnv {
    targetPkgs = _pkgs:
        [cfg.julia.package]
        ++ cfg.julia.extraPackages;

    extraOutputsToInstall = ["man" "dev"];

    name = "julia";

    profile = ''
        export DISPLAY=":0"
    '';

    runScript = cfg.shell + " -c 'julia'";
}
