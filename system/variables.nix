{
    lib,
    pkgs,
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

    config.defaults = with pkgs; {
        # keep-sorted start
        shell = fish;
        terminal = kitty;
        # keep-sorted end
    };

    # Let this here
    options = {
        var = lib.mkOption {
            type = lib.types.attrs;
            default = {};
        };
        defaults = lib.mkOption {
            type = lib.types.attrs;
            default = {};
        };
    };
}
