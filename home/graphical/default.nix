{pkgs, ...}: {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ./celluloid.nix
        ./gtk.nix
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
        obsidian
        pdfarranger
        qbittorrent
        smile
        # ventoy-full # drop till this shit is sorted out: https://github.com/NixOS/nixpkgs/issues/404663
        warp
        wineWowPackages.stable
        winetricks
        youtube-music
        # keep-sorted end
    ];
}
