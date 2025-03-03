{
    pkgs,
    ...
}: {
    imports = [
        ./shells
        ./stylix

        ./fonts.nix
        ./gaming.nix
        ./niri.nix
        ./nix-ld.nix
        ./warp.nix
    ];

    environment.systemPackages = with pkgs; [
        # nix lsp
        nixd

        # sound
        sof-firmware

        # when nix is not nixin
        distrobox
        boxbuddy

        # KDE
        kdePackages.ksystemlog
        kdePackages.partitionmanager

        # CLI tools
        asusctl

        neofetch
        pfetch

        p7zip
        rar
        unzip

        bat
        eza
        fd
        fzf
        micro
        ripgrep-all
        sd
        tealdeer

        lm_sensors
        pciutils
        util-linux

        android-tools

        # misc
        linux-wifi-hotspot
    ];

    programs.thefuck = {
        enable = true;

        alias = "fuck";
    };

    stylix.targets = {
        bat.enable = true;
        fzf.enable = true;
    };

}