{pkgs, ...}: {
    imports = [
        ./cosmic-greeter.nix
        ./niri.nix
        ./steam.nix
        ./stylix.nix
        ./warp.nix
    ];

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
        android-tools
        asusctl
        boxbuddy # when nix is not nixin
        distrobox # when nix is not nixin
        kdePackages.ksystemlog
        kdePackages.partitionmanager
        linux-wifi-hotspot
        lm_sensors
        neofetch
        nixd # nix lsp
        p7zip
        pciutils
        pfetch
        rar
        sof-firmware # sound
        unzip
        util-linux
    ];
}
