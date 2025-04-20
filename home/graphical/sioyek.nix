{
    programs.sioyek = {
        enable = true;

        bindings = {
            "command" = "<C-S-P>";
            "toggle_dark_mode" = "<C-d>";
            "toggle_horizontal_scroll_lock" = "<C-l>";
            "goto_page_with_label" = "<C-g>";
        };

        config = {
            "font_size" = "14";
            "linear_filter" = "1";
            "page_separator_color" = "0.9 0.9 0.9";
            "page_separator_width" = "2";
            "should_launch_new_window" = "1";
            "show_doc_path" = "1";
            "single_click_selects_words" = "1";
            "startup_commands" = "toggle_horizontal_scroll_lock";
            "status_bar_color" = "1 1 1";
            "status_bar_font_size" = "14";
            "status_bar_text_color" = "0 0 0";
            "ui_font" = "Calibri";
        };
    };

    xdg.mimeApps.defaultApplications = {
        "application/pdf" = "sioyek.desktop";
    };
}
