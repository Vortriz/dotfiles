{
    unify.home = {
        programs.yazi.keymap.mgr.prepend_keymap = [
            {
                on = "<S-s>";
                run = "link";
                desc = "Symlink the absolute path of yanked files";
            }
        ];
    };
}
