{
    unify.home = {
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

                edit-doc = [
                    {
                        run = ''libreoffice "$@"'';
                        orphan = true;
                        desc = "Edit in LibreOffice";
                    }
                ];

                open-with-zed = [
                    {
                        run = ''zeditor "$@"'';
                        orphan = true;
                        desc = "Open with Zed";
                    }
                ];

                send = [
                    {
                        run = ''warp "$@"'';
                        orphan = true;
                        desc = "Send via Warp";
                    }
                ];
            };

            open = {
                prepend_rules = [
                    {
                        mime = "video/*";
                        use = "open";
                    }
                ];

                append_rules = [
                    {
                        mime = "application/pdf";
                        use = "edit-doc";
                    }
                    {
                        mime = "inode/directory";
                        use = "open-with-zed";
                    }
                    {
                        mime = "*";
                        use = "send";
                    }
                ];
            };
        };
    };
}
