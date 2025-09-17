{pkgs, ...}: {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ./niri.nix
        ./steam.nix
        ./stylix.nix
        ./warp.nix
        # keep-sorted end
    ];

    programs = {
        # the default shell
        fish.enable = true;
    };

    environment.systemPackages = with pkgs; [
        # keep-sorted start
        asusctl
        boxbuddy # when nix is not nixin
        distrobox # when nix is not nixin
        exfatprogs
        gparted
        kdePackages.ksystemlog
        linux-wifi-hotspot
        lm_sensors
        p7zip
        pciutils
        rar
        sof-firmware # sound
        util-linux
        # keep-sorted end
    ];
}
