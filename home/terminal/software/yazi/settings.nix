{
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.defaults) video-player;
in {
    programs.yazi.settings = {
        mgr = {
            show_hidden = true;
            sort_by = "natural";
        };

        preview = {
            max_width = 1000;
            max_height = 1000;
        };

        confirm = {
            overwrite = true;
        };

        opener = {
            open = [
                {
                    run = ''xdg-open "$@"'';
                    orphan = true;
                    desc = "Open";
                }
            ];

            play = [
                {
                    run = ''${lib.getName video-player} "$@"'';
                    orphan = true;
                    desc = "Play";
                }
            ];
        };

        open = {
            prepend_rules = [
                {
                    mime = "video/*";
                    use = "play";
                }
            ];
        };

        plugin = {
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
}
