{
    pkgs,
    ...
}: {
    services = {
        desktopManager.plasma6.enable = true;
    };

    security.pam.services.kwallet = {
        name = "kdewallet";
        enableKwallet = true;
    };
}