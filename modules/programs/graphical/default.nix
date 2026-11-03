{
    unify.home = { pkgs, ... }: {
        home.packages = with pkgs; [
            # keep-sorted start
            # (bottles.override {removeWarningPopup = true;})
            anydesk
            gnome-calculator
            gnome-characters
            libreoffice
            onlyoffice-desktopeditors
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
