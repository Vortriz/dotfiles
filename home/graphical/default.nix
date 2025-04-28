{pkgs, ...}: {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ./celluloid.nix
        ./nemo.nix
        ./nomacs.nix
        ./sioyek.nix
        ./telegram.nix
        ./zotero.nix

        ./firefox
        #keep-sorted end
    ];

    home.packages = with pkgs; [
        # keep-sorted start
        anydesk
        bottles
        diffpdf
        discord
        gnome-calculator
        kdePackages.filelight
        mission-center
        nautilus
        obsidian
        pdfarranger
        qbittorrent
        ventoy-full
        vlc
        warp
        wineWowPackages.stable
        winetricks
        youtube-music
        # keep-sorted end
    ];
}
