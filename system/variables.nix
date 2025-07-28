{
    config,
    inputs,
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

        monospaceFont = pkgs.maple-mono.Normal-NF-unhinted;
        monospaceFontName = "Maple Mono Normal NF";
    };

    config.defaults =
        (with pkgs; {
            # keep-sorted start
            browser = firefox;
            file-manager = yazi;
            shell = fish;
            terminal = kitty;
            video-player = haruna;
            wallpaper = swww-git;
            # keep-sorted end
        })
        // (with inputs; {
            # keep-sorted start
            # keep-sorted end
        });

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
