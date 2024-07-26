# vim:ft=kitty

## name: Catppuccin
## author: Pocco81 (https://github.com/Pocco81)
## license: MIT
## upstream: https://raw.githubusercontent.com/catppuccin/kitty/main/catppuccin.conf
## blurb: Soothing pastel theme for the high-spirited!
{
    allow_remote_control = true;
    enabled_layouts = "splits:split_axis=vertical";
    # General settings
    window_padding_width = 8;
    font_size = 12;
    font_family = "FiraCode";

    # The basic colors
    foreground              = "#E2E0EC";
    background              = "#11111B";
    selection_foreground    = "#D9E0EE";
    selection_background    = "#575268";

    # Transparent Background
    background_opacity      = "1.0";
    # background_opacity      = "0.9";

    # Cursor colors
    cursor                  = "#F5E0DC";
    cursor_text_color       = "#11111B";

    # URL underline color when hovering with mouse
    url_color               = "#F5E0DC";

    # kitty window border colors
    active_border_color     = "#C9CBFF";
    inactive_border_color   = "#575268";
    bell_border_color       = "#FAE3B0";

    # OS Window titlebar colors
    wayland_titlebar_color = "system";
    macos_titlebar_color = "system";

    #: Tab bar colors
    active_tab_foreground   = "#F5C2E7";
    active_tab_background   = "#575268";
    inactive_tab_foreground = "#D9E0EE";
    inactive_tab_background = "#11111B";
    tab_bar_background      = "#161320";

    # Colors for marks (marked text in the terminal)
    mark1_foreground = "#11111B";
    mark1_background = "#96CDFB";
    mark2_foreground = " #11111B";
    mark2_background = "#F5C2E7";
    mark3_foreground = "#11111B";
    mark3_background = "#B5E8E0";
    
    #: The 16 terminal colors
    #: black
    color0 = "#2B273F";
    color8 = "#61588E";

    #: red
    color1 = "#E99FAB";
    color9 = "#E99FAB";

    #: green
    color2  = "#A4E09F";
    color10 = "#A4E09F";

    #: yellow
    color3  = "#F9E2AF";
    color11 = "#F9E2AF";

    #: blue
    color4  = "#89B4FA";
    color12 = "#89B4FA";

    #: magenta
    color5  = "#CBA6F7";
    color13 = "#CBA6F7";

    #: cyan
    color6  = "#89DCEB";
    color14 = "#89DCEB";

    #: white
    color7  = "#CDD6F4";
    color15 = "#CDD6F4";
}
