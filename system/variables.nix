{
    config,
    inputs,
    lib,
    pkgs,
    system,
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
            code-editor = zed-editor;
            file-manager = yazi;
            shell = fish;
            terminal = kitty;
            video-player = celluloid;
            wallpaper = swww-git;
            # keep-sorted end
        })
        // (with inputs; {
            # keep-sorted start
            desktop-shell = niri-shell.packages.${system}.default;
            launcher = sherlock.packages.${system}.default;
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
