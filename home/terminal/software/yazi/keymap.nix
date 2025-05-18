{
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.defaults) shell;
in {
    manager.prepend_keymap = [
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
            on = "F";
            run = "plugin smart-filter";
            desc = "Smart filter";
        }

        # what-size
        {
            on = "?";
            run = "plugin what-size";
            desc = "Calc size of selection or cwd";
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
    ];
}
