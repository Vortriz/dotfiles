{
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) monospaceFontName;
    inherit (osConfig.defaults) shell;

    fontName = lib.mkForce monospaceFontName;
    fontSize = lib.mkForce 18;
in {
    # keep-sorted start block=yes
    auto_update = false;
    buffer_font_family = fontName;
    buffer_font_size = fontSize;
    cursor_shape = "bar";
    git.inline_blame.enabled = false;
    icon_theme = "VSCode Icons (Dark)";
    languages = {
        Nix = {
            language_servers = ["nil" "nixd"];
            formatter.external = {
                command = "alejandra";
                arguments = ["--quiet"];
            };
        };
        Typst = {
            language_servers = ["tinymist"];
        };
    };
    lsp = lib.mergeAttrsList (
        map (name: {
            ${name}.binary = {
                path_lookup = true;
                path = lib.getExe pkgs.${name};
            };
        }) ["rust-analyzer" "nixd" "nil" "tinymist"]
    );
    minimap = {
        show = "always";
        thumb = "always";
    };
    tab_size = 4;
    tabs = {
        file_icons = true;
        git_status = true;
    };
    terminal.detect_venv.on.activate_script = "${lib.getName shell}";
    toolbar.title = true;
    ui_font_family = fontName;
    ui_font_size = fontSize;
    unnecessary_code_fade = 0.5;
    use_smartcase_search = true;
    # keep-sorted end
}
