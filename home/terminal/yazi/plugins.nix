{pkgs, ...}: {
    programs.yazi.plugins = let
        plugins-src = pkgs.callPackages ./sources/generated.nix {};
        inherit (plugins-src) official-plugins-monorepo other-monorepo;

        official-plugins = [
            # keep-sorted start
            "jump-to-char"
            "mount"
            "piper"
            "smart-enter"
            "smart-filter"
            "toggle-pane"
            "zoom"
            # keep-sorted end
        ];

        other-monorepo-plugins = [
            # keep-sorted start
            "first-non-directory"
            # keep-sorted end
        ];

        other-plugins = [
            # keep-sorted start
            "bunny"
            "custom-shell"
            "mediainfo"
            "office"
            "ouch"
            "restore"
            "starship"
            "what-size"
            # keep-sorted end
        ];
    in
        builtins.listToAttrs (map (name: {
            inherit name;
            value = "${official-plugins-monorepo.src}/${name}.yazi";
        })
        official-plugins)
        // builtins.listToAttrs (map (name: {
            inherit name;
            value = "${other-monorepo.src}/${name}.yazi";
        })
        other-monorepo-plugins)
        // builtins.listToAttrs (map (name: {
            inherit name;
            value = plugins-src.${name}.src;
        })
        other-plugins);

    # dependencies
    home.packages = with pkgs; [
        # keep-sorted start
        ffmpeg-full # mediainfo-yazi
        glow # glow-yazi
        imagemagick # zoom
        libreoffice # office
        mediainfo # mediainfo-yazi
        ouch # ouch-yazi
        poppler-utils # office
        ripdrag # drag and drop
        trash-cli # restore-yazi
        udisks # mount-yazi
        # keep-sorted end
    ];
}
