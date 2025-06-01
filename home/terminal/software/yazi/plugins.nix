{
    lib,
    pkgs,
    ...
}: {
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
            # keep-sorted end
        ];

        other-monorepo-plugins = [
            # keep-sorted start
            "first-non-directory"
            # keep-sorted end
        ];

        other-plugins = [
            # keep-sorted start
            "custom-shell"
            "mediainfo"
            "office"
            "ouch"
            "restore"
            "starship"
            "what-size"
            "yamb"
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
        libreoffice # office
        mediainfo # mediainfo-yazi
        ouch # ouch-yazi
        poppler-utils # office
        ripdrag # drag and drop
        trash-cli # restore-yazi
        udisks # mount-yazi
        # keep-sorted end
    ];

    xdg.configFile."yazi/bookmark".text =
        [
            ["vortriz" "/home/vortriz/" "h"]
            [".config" "/home/vortriz/.config/" "c"]
            ["nonlinear-vault" "/mnt/HOUSE/nonlinear-vault/" "n"]
            ["personal" "/mnt/HOUSE/personal/" "p"]
            ["downloads" "/mnt/HOUSE/downloads/" "d"]
            ["HOUSE" "/mnt/HOUSE/" "s"]
            ["dotfiles" "/home/vortriz/dotfiles/" "0"]
            ["dev" "/mnt/HOUSE/dev/" "1"]
        ]
        |> map (lib.strings.concatStringsSep "\t")
        |> lib.concatLines;
}
