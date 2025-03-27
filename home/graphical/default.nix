{
    pkgs,
    ...
}: {
    imports = [
        ./firefox

        ./sioyek.nix
        ./zotero.nix
    ];

    home.packages = with pkgs; [
        # file managers
        nautilus

        # file transfer
        warp

        # image viewer
        nomacs

        # music
        youtube-music

        # productivity
        obsidian

        # remote desktop
        anydesk

        # social media
        discord
        telegram-desktop

        # system monitor
        mission-center

        # torrent
        qbittorrent

        # utilities
        gnome-calculator
        kdePackages.filelight
        pdfarranger
        ventoy-full

        # video player
        mpv
        vlc

        # wine
        bottles
        winetricks
        wineWowPackages.stable
    ];
}