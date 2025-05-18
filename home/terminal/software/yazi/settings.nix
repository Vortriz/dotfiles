{
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.defaults) video-player;
in {
    manager = {
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
        prepend_previewers = [
            # glow
            {
                name = "*.md";
                run = "glow";
            }

            # mediainfo
            {
                mime = "{audio,video,image}/*";
                run = "mediainfo";
            }
            {
                mime = "application/subrip";
                run = "mediainfo";
            }

            # office
            {
                mime = "application/openxmlformats-officedocument.*";
                run = "office";
            }
            {
                mime = "application/oasis.opendocument.*";
                run = "office";
            }
            {
                mime = "application/ms-*";
                run = "office";
            }
            {
                mime = "application/msword";
                run = "office";
            }
            {
                name = "*.docx";
                run = "office";
            }

            # ouch
            {
                mime = "application/*zip";
                run = "ouch";
            }
            {
                mime = "application/x-tar";
                run = "ouch";
            }
            {
                mime = "application/x-bzip2";
                run = "ouch";
            }
            {
                mime = "application/x-7z-compressed";
                run = "ouch";
            }
            {
                mime = "application/x-rar";
                run = "ouch";
            }
            {
                mime = "application/x-xz";
                run = "ouch";
            }
        ];

        prepend_preloaders = [
            # mediainfo
            {
                mime = "{audio,video,image}/*";
                run = "mediainfo";
            }
            {
                mime = "application/subrip";
                run = "mediainfo";
            }

            # office
            {
                mime = "application/openxmlformats-officedocument.*";
                run = "office";
            }
            {
                mime = "application/oasis.opendocument.*";
                run = "office";
            }
            {
                mime = "application/ms-*";
                run = "office";
            }
            {
                mime = "application/msword";
                run = "office";
            }
            {
                name = "*.docx";
                run = "office";
            }
        ];
    };
}
