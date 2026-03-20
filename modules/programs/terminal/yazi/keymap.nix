{
    unify.home = {
        programs.yazi.keymap.mgr.prepend_keymap = [
            {
                on = "<S-s>";
                run = "link";
                desc = "Symlink the absolute path of yanked files";
            }
            {
                on = ["g" "s"];
                run = "cd sftp://cluster/rishi";
                desc = "Go to cluster";
            }
            {
                on = ["g" "p"];
                run = "cd sftp://parambrahma/rishi";
                desc = "Go to parambrahma";
            }
        ];
    };
}
