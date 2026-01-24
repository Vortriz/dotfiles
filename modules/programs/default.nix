{
    unify = {
        nixos = {pkgs, ...}: {
            environment.systemPackages = with pkgs; [
                # keep-sorted start
                asusctl
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
        };
    };
}
