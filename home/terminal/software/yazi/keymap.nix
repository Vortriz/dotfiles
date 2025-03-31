{
    programs.yazi.keymap = {
        manager.prepend_keymap = [
            # smart-enter
            {
                on = "<Enter>";
                run = "plugin smart-enter";
                desc = "Enter the child directory, or open the file";
            }

            # jump-to-char
            {
                on = "f";
                run = "plugin jump-to-char";
                desc = "Jump to char";
            }

            # smart-filter
            {
                on = "F";
                run = "plugin smart-filter";
                desc = "Smart filter";
            }

            # ouch
            {
                on = "C";
                run = "plugin ouch --args=zip";
                desc = "Compress with ouch";
            }

            # first-non-directory
            {
                on = "G";
                run = "plugin first-non-directory";
                desc = "Jumps to the first file";
            }

            # yamb
            {
                on = "j";
                run = "plugin yamb jump_by_key";
                desc = "Jump bookmark by key";
            }
            {
                on = ["b" "a"];
                run = "plugin yamb save";
                desc = "Add bookmark";
            }
            {
                on = ["b" "d"];
                run = "plugin yamb delete_by_key";
                desc = "Delete bookmark by key";
            }
            {
                on = ["b" "r"];
                run = "plugin yamb rename_by_key";
                desc = "Rename bookmark by key";
            }

            # what-size
            {
                on = "?";
                run = "plugin what-size";
                desc = "Calc size of selection or cwd";
            }

            # restore
            {
                on = "R";
                run = "plugin restore";
                desc = "Restore last deleted files/folders";
            }

            # file-navigation-wraparound
            {
                on = "<Up>";
                run = "plugin file-navigation-wraparound -1";
                desc = "Move cursor up";
            }
            {
                on = "<Down>";
                run = "plugin file-navigation-wraparound 1";
                desc = "Move cursor down";
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

            # mount
            {
                on = "M";
                run = "plugin mount";
                desc = "Mount";
            }
        ];
    };
}
