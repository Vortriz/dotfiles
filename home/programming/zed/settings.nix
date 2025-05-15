{
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.var) monospaceFontName shell;
    fontSize = lib.mkForce 18;
in {
    buffer_font_family = lib.mkForce monospaceFontName;
    buffer_font_size = fontSize;
    git = {
        inline_blame = {
            enabled = false;
        };
    };
    icon_theme = "VSCode Icons (Dark)";
    minimap = {
        show = "always";
        thumb = "always";
    };
    tab_size = 4;
    tabs = {
        file_icons = true;
        git_status = true;
    };
    terminal = {
        detect_venv = {
            on = {
                activate_script = shell;
            };
        };
    };
    ui_font_family = lib.mkForce monospaceFontName;
    ui_font_size = fontSize;
    unnecessary_code_fade = 0.5;
    use_smartcase_search = true;
}
