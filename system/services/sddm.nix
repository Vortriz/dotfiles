{
    pkgs,
    ...
}: {
    services = {
        displayManager.sddm.enable = true;
    };
}