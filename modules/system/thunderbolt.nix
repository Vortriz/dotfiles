{ pkgs, inputs, config, ... }:

{
    environment.systemPackages = with pkgs; [
        thunderbolt
        plasma-thunderbolt
        kdePackages.plasma-thunderbolt
    ];
}