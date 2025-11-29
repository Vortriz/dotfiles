{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        anydesk
        baobab
        bottles
        celluloid
        diffpdf
        gnome-calculator
        gnome-characters
        libreoffice
        obsidian
        pdfarranger
        qbittorrent
        vesktop
        warp
        winetricks
        youtube-music
        # keep-sorted end
    ];
}
