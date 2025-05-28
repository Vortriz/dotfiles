{
    programs.sioyek = {
        enable = true;

        # keep-sorted start block=yes
        bindings = {
            # keep-sorted start
            "close_window" = "q";
            "command" = "<C-P>";
            "goto_page_with_label" = "<C-g>";
            "toggle_dark_mode" = "<C-d>";
            "toggle_horizontal_scroll_lock" = "<C-l>";
            # keep-sorted end
        };
        config = {
            # keep-sorted start
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
            # keep-sorted end
        };
        # keep-sorted end
    };

    xdg.mimeApps.defaultApplications = {
        "application/pdf" = "sioyek.desktop";
    };
}
