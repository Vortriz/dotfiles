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

            edit-pdf = [
                {
                    run = ''libreoffice "$@"'';
                    orphan = true;
                    desc = "Edit PDF";
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

            append_rules = [
                {
                    mime = "application/pdf";
                    use = "edit-pdf";
                }
            ];
        };
    };
}
