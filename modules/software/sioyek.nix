{ pkgs, ... }:

{
    programs.sioyek = {
        enable = true;
        config = {
            "should_launch_new_window" = "1";
            "linear_filter" = "1";
            "ui_font" = "Calibri";
            "font_size" = "16";
            "status_bar_color" = "1 1 1";
            "status_bar_text_color" = "0 0 0";
            "status_bar_font_size" = "16";
            "page_separator_width" = "2";
            "page_separator_color" = "0.9 0.9 0.9";
            "show_doc_path" = "1";
        };
    };
}
