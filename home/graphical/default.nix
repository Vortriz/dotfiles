{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        anydesk
        baobab
        bottles
        celluloid
        diffpdf
        gnome-calculator
        obsidian
        pdfarranger
        qbittorrent
        smile
        vesktop
        warp
        wineWowPackages.stable
        winetricks
        youtube-music
        # keep-sorted end
    ];
}
