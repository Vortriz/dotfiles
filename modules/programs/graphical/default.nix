{
    unify.home = {pkgs, ...}: {
        home.packages = with pkgs; [
            # keep-sorted start
            (bottles.override {removeWarningPopup = true;})
            anydesk
            gnome-calculator
            gnome-characters
            libreoffice
            obsidian
            pavucontrol
            pear-desktop
            qbittorrent
            warp
            # keep-sorted end
        ];
    };
}
