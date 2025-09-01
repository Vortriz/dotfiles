{
    lib,
    pkgs,
    ...
}: {
    programs.yazi = {
        plugins = let
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
                "hover-after-moved"
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

        settings.plugin = {
            prepend_previewers =
                [
                    # glow/piper markdown
                    {
                        name = ["*.md"];
                        run = [''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"''];
                    }

                    # mediainfo
                    {
                        mime = ["{audio,video,image}/*" "application/subrip"];
                        run = ["mediainfo"];
                    }

                    # office
                    {
                        name = ["application/openxmlformats-officedocument.*" "application/oasis.opendocument.*" "application/ms-*" "application/msword" "*.docx"];
                        run = ["office"];
                    }

                    # ouch
                    {
                        mime = ["application/*zip" "application/*tar" "application/*rar" "application/x-bzip2" "application/x-7z-compressed" "application/x-xz"];
                        run = [''piper -- ouch list -tA "$1"''];
                    }
                ]
                |> map (lib.attrsets.cartesianProduct)
                |> lib.lists.concatLists;

            prepend_preloaders =
                [
                    # mediainfo
                    {
                        mime = ["{audio,video,image}/*" "application/subrip"];
                        run = ["mediainfo"];
                    }
                ]
                |> map (lib.attrsets.cartesianProduct)
                |> lib.lists.concatLists;
        };
    };

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
