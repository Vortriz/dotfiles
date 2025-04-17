{pkgs, ...}: {
    imports = [
        ./firefox

        ./nemo.nix
        ./sioyek.nix
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
        nomacs # image viewer
        obsidian
        pdfarranger
        qbittorrent
        telegram-desktop
        ventoy-full
        vlc
        warp
        winetricks
        wineWowPackages.stable
        youtube-music
    ];
}
