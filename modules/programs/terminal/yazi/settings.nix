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

            opener = {
                edit-doc = [
                    {
                        run = "onlyoffice-desktopeditors %s";
                        orphan = true;
                        desc = "Edit in OnlyOffice";
                    }
                ];

                edit-with-zed = [
                    {
                        run = "zeditor %s";
                        orphan = true;
                        desc = "Edit with Zed";
                    }
                ];

                send = [
                    {
                        run = "warp %s";
                        orphan = true;
                        desc = "Send via Warp";
                    }
                ];
            };

            open = {
                prepend_rules = [
                    {
                        mime = "text/*";
                        use = ["edit" "edit-with-zed" "open" "reveal" "send"];
                    }
                    {
                        mime = "inode/empty";
                        use = ["edit" "edit-with-zed" "open" "reveal" "send"];
                    }
                    {
                        mime = "application/json";
                        use = ["open" "edit" "edit-with-zed" "reveal" "send"];
                    }
                    {
                        mime = "application/pdf";
                        use = ["open" "reveal" "edit-doc" "send"];
                    }
                    {
                        mime = "application/{*zip,*tar,*rar,x-bzip2,x-7z-compressed,x-xz}";
                        use = ["extract" "reveal" "send"];
                    }
                    {
                        mime = "folder/local";
                        use = ["open" "reveal" "edit-with-zed" "send"];
                    }
                    {
                        mime = "vfs/{absent,stale}";
                        use = ["download"];
                    }
                    {
                        url = "*";
                        use = ["open" "reveal" "send"];
                    }
                ];
            };
        };
    };
}
