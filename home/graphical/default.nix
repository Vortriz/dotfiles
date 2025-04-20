{pkgs, ...}: {
    imports = [
        ./firefox

        ./nemo.nix
        ./nomacs.nix
        ./sioyek.nix
        ./telegram.nix
        ./zotero.nix
    ];

    home.packages = with pkgs; [
        anydesk
        bottles
        diffpdf
        discord
        gnome-calculator
        kdePackages.filelight
        mission-center
        mpv
        nautilus
        obsidian
        pdfarranger
        qbittorrent
        ventoy-full
        vlc
        warp
        winetricks
        wineWowPackages.stable
        youtube-music
    ];
}
