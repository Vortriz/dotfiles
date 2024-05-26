{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        cloudflare-warp
        
        asusctl
        lm_sensors
        # wlr-randr (to-add)

        libsForQt5.qtstyleplugin-kvantum

        kwallet-pam

        # thunderbolt
        thunderbolt
        plasma-thunderbolt
        kdePackages.plasma-thunderbolt
    ];
}