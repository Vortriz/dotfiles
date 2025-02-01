{
    pkgs,
    ...
}: {
    imports = [
        ./firefox
        ./programming
        ./wayland

        ./sioyek.nix
    ];

    home.packages = with pkgs; [
        # download manager
        persepolis

        # file managers
        nautilus
        superfile

        # file transfer
        warp

        # image editor
        gimp

        # image viewer
        nomacs

        # music
        youtube-music

        # office suite
        libreoffice

        # productivity
        obsidian

        # social media
        discord
        telegram-desktop

        # system monitor
        mission-center

        # remote desktop
        anydesk

        # torrent
        qbittorrent

        # video player
        vlc
        mpv

        # wine
        wineWowPackages.stable
        winetricks
        bottles

        # utilities
        gnome-calculator
        filelight
        ventoy-full
    ];
}