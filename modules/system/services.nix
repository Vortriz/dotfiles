{ pkgs, ... }:

{
    services = {
        cpupower-gui.enable = true;
        touchegg.enable = true;
        preload.enable = true;
        asusd.enable = true;
        asusd.enableUserService = true;
    };
}