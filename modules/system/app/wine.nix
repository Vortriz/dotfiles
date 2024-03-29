{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [ 
        wineWowPackages.stable
        bottles
    ];
}