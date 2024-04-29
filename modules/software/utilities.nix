{ pkgs, ... }:

{
    home.packages = with pkgs; [
        neofetch
        unzip
        p7zip
        rar
        filelight
    ];

    services = {
        copyq.enable = true;
        kdeconnect.enable = true;
    };
}