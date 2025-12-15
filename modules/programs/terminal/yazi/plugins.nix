{
    unify.home = {
        lib,
        pkgs,
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
                        hover-after-moved
                        jump-to-char
                        mediainfo
                        mount
                        ouch
                        piper
                        restore
                        smart-enter
                        smart-filter
                        starship
                        toggle-pane
                        # zoom # [MARK] wait for yazi to cut a new release
                        # keep-sorted end
                        ;
                }
                # from nur
                // (with pkgs; {
                    bunny = yazi-bunny;
                    custom-shell = yazi-custom-shell;
                    hover-after-moved = yazi-hover-after-moved;
                    office = yazi-office;
                    what-size = yazi-what-size;
                });

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
                            name = ["application/{openxmlformats-officedocument.*,oasis.opendocument.*,ms-*,msword}"];
                            run = ["office"];
                        }

                        # ouch
                        {
                            mime = ["application/{*zip,*tar,*rar,x-bzip2,x-7z-compressed,x-xz}"];
                            run = [''piper -- ouch list -tA "$1"''];
                        }
                    ]
                    |> map cartesianProduct
                    |> concatLists;

                prepend_preloaders =
                    [
                        # mediainfo
                        {
                            mime = ["{audio,video,image}/*" "application/subrip"];
                            run = ["mediainfo"];
                        }
                    ]
                    |> map cartesianProduct
                    |> concatLists;
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
    };
}
