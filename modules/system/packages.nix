{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        cloudflare-warp
        
        asusctl
        lm_sensors

        # libsForQt5.qtstyleplugin-kvantum
        # qt5ct

        # thunderbolt
        thunderbolt
        plasma-thunderbolt
        kdePackages.plasma-thunderbolt
    ];

    # nixpkgs.config.qt5 = {
    #     enable = true;
    #     platformTheme = "qt5ct"; 
    #         style = {
    #         package = pkgs.utterly-nord-plasma;
    #         name = "Utterly Nord Plasma";
    #     };
    # };
}