{inputs, ...}: {
    unify = {
        nixos = {
            nixpkgs.overlays = [inputs.nur-vortriz.overlays.yaziPlugins];

            # gvfs
            services.gvfs.enable = true;
        };

        home = {
            lib,
            pkgs,
            hostConfig,
            ...
        }: let
            inherit (lib) map;
            inherit (lib.lists) concatLists;
            inherit (lib.attrsets) cartesianProduct;
        in {
            programs.yazi = {
                plugins =
                    {
                        inherit
                            (pkgs.yaziPlugins)
                            # keep-sorted start
                            jump-to-char
                            mediainfo
                            ouch
                            piper
                            restore
                            smart-enter
                            smart-filter
                            starship
                            toggle-pane
                            # zoom # [MARK] wait for nixpkgs to add it
                            # keep-sorted end
                            ;
                    }
                    # from nur
                    // {
                        inherit
                            (pkgs.yaziPlugins)
                            # keep-sorted start
                            bunny
                            custom-shell
                            enhance-piper
                            file-extra-metadata
                            gvfs
                            hover-after-moved
                            office
                            what-size
                            # keep-sorted end
                            ;
                    };

                settings.plugin = {
                    prepend_previewers =
                        [
                            # glow/enhance-piper
                            {
                                url = ["*.md"];
                                run = [''enhance-piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"''];
                            }

                            # gvfs
                            {
                                url = ["/run/user/1000/gvfs/**/*" "/run/media/${hostConfig.username}/**/*"];
                                run = ["noop"];
                            }

                            # mediainfo
                            {
                                mime = ["{audio,video,image}/*" "application/subrip"];
                                run = ["mediainfo"];
                            }

                            # office
                            {
                                mime = ["application/{openxmlformats-officedocument.*,oasis.opendocument.*,ms-*,msword}"];
                                run = ["office"];
                            }

                            # ouch/enhance-piper
                            {
                                mime = ["application/{*zip,*tar,*rar,x-bzip2,x-7z-compressed,x-xz}"];
                                run = [''enhance-piper -- ouch list -tA "$1"''];
                            }
                        ]
                        |> map cartesianProduct
                        |> concatLists;

                    prepend_preloaders =
                        [
                            # gvfs
                            {
                                url = ["/run/user/1000/gvfs/**/*" "/run/media/${hostConfig.username}/**/*"];
                                run = ["noop"];
                            }

                            # mediainfo
                            {
                                mime = ["{audio,video,image}/*" "application/subrip"];
                                run = ["mediainfo"];
                            }
                        ]
                        |> map cartesianProduct
                        |> concatLists;

                    prepend_spotters = [
                        # file-extra-metadata
                        {
                            url = "*";
                            run = "file-extra-metadata";
                        }
                    ];
                };

                keymap.mgr.prepend_keymap = [
                    # bunny
                    {
                        on = "j";
                        run = "plugin bunny";
                        desc = "Start bunny.yazi";
                    }

                    # custom-shell
                    {
                        on = ["'" ";"];
                        run = "plugin custom-shell -- fish --interactive";
                        desc = "custom-shell as default, interactive";
                    }
                    {
                        on = ["'" ":"];
                        run = "plugin custom-shell -- fish --interactive --block";
                        desc = "custom-shell as default, interactive, block";
                    }

                    # drag and drop
                    {
                        on = "<C-n>";
                        run = ''shell 'ripdrag %s -anx 2>/dev/null &' --confirm'';
                        desc = "Drag and drop";
                    }

                    # first-non-directory
                    {
                        on = "G";
                        run = "plugin first-non-directory";
                        desc = "Jumps to the first file";
                    }

                    # gvfs
                    {
                        on = ["M" "m"];
                        run = "plugin gvfs -- select-then-mount --jump";
                        desc = "Select device to mount and jump to its mount point";
                    }
                    {
                        on = ["M" "u"];
                        run = "plugin gvfs -- select-then-unmount --eject";
                        desc = "Select device then eject";
                    }
                    {
                        on = ["M" "U"];
                        run = "plugin gvfs -- select-then-unmount --eject --force";
                        desc = "Select device then force to eject/unmount";
                    }

                    # jump-to-char
                    {
                        on = "f";
                        run = "plugin jump-to-char";
                        desc = "Jump to char";
                    }

                    # ouch
                    {
                        on = "C";
                        run = "plugin ouch --args=zip";
                        desc = "Compress with ouch";
                    }

                    # restore
                    {
                        on = "R";
                        run = "plugin restore";
                        desc = "Restore last deleted files/folders";
                    }

                    # smart-enter
                    {
                        on = "<Enter>";
                        run = "plugin smart-enter";
                        desc = "Enter the child directory, or open the file";
                    }

                    # smart-filter
                    {
                        on = "J";
                        run = "plugin smart-filter";
                        desc = "Smart filter";
                    }

                    # toggle-pane
                    {
                        on = "T";
                        run = "plugin toggle-pane max-current";
                        desc = "Maximize or restore the preview pane";
                    }

                    # what-size
                    {
                        on = "?";
                        run = "plugin what-size";
                        desc = "Calc size of selection or cwd";
                    }

                    # zoom
                    # {
                    #     on = "+";
                    #     run = "plugin zoom 1";
                    #     desc = "Zoom in hovered file";
                    # }
                    # {
                    #     on = "-";
                    #     run = "plugin zoom -1";
                    #     desc = "Zoom out hovered file";
                    # }
                ];

                extraPackages = with pkgs; [
                    # keep-sorted start
                    ffmpeg-full # mediainfo-yazi
                    glib # gvfs-yazi
                    glow # glow-yazi
                    imagemagick # zoom
                    libreoffice # office
                    mediainfo # mediainfo-yazi
                    ouch # ouch-yazi
                    poppler-utils # office
                    ripdrag # drag and drop
                    trash-cli # restore-yazi
                    # keep-sorted end
                ];
            };
        };
    };
}
