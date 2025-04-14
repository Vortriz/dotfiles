{
    config,
    lib,
    ...
}: {
    config.var = rec {
        hostname = "nixos";
        username = "vortriz";
        dotfilesDir = "/home/" + username + "/dotfiles";

        timeZone = "Asia/Kolkata";
        defaultLocale = "en_IN";
        extraLocale = defaultLocale;

        storageDir = "/mnt/HOUSE";
        downloadsDir = storageDir + "/downloads";
    };

    # Let this here
    options = {
        var = lib.mkOption {
            type = lib.types.attrs;
            default = {};
        };
    };
}
