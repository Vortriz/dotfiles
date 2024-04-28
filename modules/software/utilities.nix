{ pkgs, ... }:

{
    home.packages = with pkgs; [
        neofetch
        unzip
        p7zip
        filelight
    ];

    services = {
        copyq.enable = true;
        kdeconnect.enable = true;
    };
}