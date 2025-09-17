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
        # ventoy-full # drop till this shit is sorted out: [ERROR] https://github.com/NixOS/nixpkgs/issues/404663
        vesktop
        warp
        wineWowPackages.stable
        winetricks
        youtube-music
        # keep-sorted end
    ];
}
