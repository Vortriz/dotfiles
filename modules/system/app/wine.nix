
{ inputs, config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [ wineWowPackages.waylandFull ];
}