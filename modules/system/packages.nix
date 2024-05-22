{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        cloudflare-warp
        
        asusctl
        lm_sensors

        libsForQt5.qtstyleplugin-kvantum

        kwallet-pam

        # thunderbolt
        thunderbolt
        plasma-thunderbolt
        kdePackages.plasma-thunderbolt
    ];
}