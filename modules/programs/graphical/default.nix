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
            pdfpc
            pear-desktop
            qbittorrent
            syncplay
            warp
            # keep-sorted end
        ];
    };
}
