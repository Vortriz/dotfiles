-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")

require("yamb"):setup {
    -- Optional, the path ending with path seperator represents folder.
    bookmarks = bookmarks,
    -- Optional, recieve notification everytime you jump.
    jump_notify = true,
    -- Optional, the cli of fzf.
    cli = "fzf",
    -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
    keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
    -- Optional, the path of bookmarks
    path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark") or
                (os.getenv("HOME") .. "/.config/yazi/bookmark"),
}

-- augment-command
require("augment-command"):setup({
    prompt = false,
    default_item_group_for_prompt = "hovered",
    smart_enter = false,
    smart_paste = false,
    smart_tab_create = false,
    smart_tab_switch = false,
    confirm_on_quit = false,
    open_file_after_creation = false,
    enter_directory_after_creation = false,
    use_default_create_behaviour = false,
    enter_archives = false,
    extract_retries = 3,
    recursively_extract_archives = false,
    preserve_file_permissions = false,
    must_have_hovered_item = false,
    skip_single_subdirectory_on_enter = false,
    skip_single_subdirectory_on_leave = false,
    smooth_scrolling = false,
    scroll_delay = 0.02,
    wraparound_file_navigation = true,
})

-- custom-shell
require("custom-shell"):setup({
    history_path = "default",
    save_history = true,
})

-- auto-layout
require("auto-layout")