{ pkgs, ... }:

{
    # home.packages = [ pkgs.kdeconnect ];

    services.kdeconnect = {
        enable = true;
    };
}