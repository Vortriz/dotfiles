{
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.defaults) shell;
in {
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
                run = "plugin custom-shell -- ${lib.getName shell} --interactive";
                desc = "custom-shell as default, interactive";
            }
            {
                on = ["'" ":"];
                run = "plugin custom-shell -- ${lib.getName shell} --interactive --block";
                desc = "custom-shell as default, interactive, block";
            }

            # drag and drop
            {
                on = "<C-n>";
                run = ''shell 'ripdrag "$@" -anx 2>/dev/null &' --confirm'';
                desc = "Drag and drop";
            }

            # first-non-directory
            {
                on = "G";
                run = "plugin first-non-directory";
                desc = "Jumps to the first file";
            }

            # jump-to-char
            {
                on = "f";
                run = "plugin jump-to-char";
                desc = "Jump to char";
            }

            # mount
            {
                on = "M";
                run = "plugin mount";
                desc = "Mount";
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
            {
                on = "+";
                run = "plugin zoom 1";
                desc = "Zoom in hovered file";
            }
            {
                on = "-";
                run = "plugin zoom -1";
                desc = "Zoom out hovered file";
            }
        ];

        extraPackages = with pkgs; [
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
    };
}
