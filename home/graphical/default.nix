{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        anydesk
        bottles
        celluloid
        diffpdf
        gnome-calculator
        kdePackages.filelight
        obsidian
        pdfarranger
        qbittorrent
        smile
        # ventoy-full # drop till this shit is sorted out: [ERROR] https://github.com/NixOS/nixpkgs/issues/404663
        vesktop
        warp
        wineWowPackages.stable
        winetricks
        youtube-music
        # keep-sorted end
    ];
}
