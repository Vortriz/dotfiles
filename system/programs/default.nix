{pkgs, ...}: {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ./cosmic-greeter.nix
        ./niri.nix
        ./steam.nix
        ./stylix.nix
        ./warp.nix
        # keep-sorted end
    ];

    programs = {
        dconf.enable = true;

        # the default shell
        fish.enable = true;
    };

    environment.systemPackages = with pkgs; [
        # keep-sorted start
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
        # keep-sorted end
    ];
}
