{
    unify.nixos = {
        services = {
            # Auto mounting
            udisks2.enable = true;
            gvfs.enable = true;
            devmon.enable = true;
        };

        programs.gnome-disks.enable = true;
    };
}
