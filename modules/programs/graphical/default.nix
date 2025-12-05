{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            # keep-sorted start
            anydesk
            bottles
            gnome-calculator
            gnome-characters
            libreoffice
            obsidian
            pavucontrol
            qbittorrent
            warp
            youtube-music
            # keep-sorted end
        ];
    };
}
