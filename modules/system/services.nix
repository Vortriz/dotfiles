{ pkgs, ... }:

{
    services = {
        cpupower-gui.enable = false;
        touchegg.enable = true;
        preload.enable = true;
        asusd.enable = true;
        asusd.enableUserService = true;
    };
}