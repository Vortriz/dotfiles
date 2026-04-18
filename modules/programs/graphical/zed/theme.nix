{
    unify.home = {config, ...}: let
        inherit (config.lib.stylix.colors.withHashtag) base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F;
        transparent = "#00000000";
    in {
        programs.zed-editor.themes = {
            custom = {
                "$schema" = "https://zed.dev/schema/themes/v0.2.0.json";
                name = "My Themes";
                author = "vortriz";
                themes = [
                    {
                        name = "Custom Dark";
                        appearance = "dark";
                        style = {
                            "border" = base02;
                            "border.variant" = base01;
                            "border.focused" = base0D;
                            "border.selected" = base02;
                            "border.transparent" = transparent;
                            "border.disabled" = base03;
                            "elevated_surface.background" = "${base01}f2";
                            "surface.background" = "${base01}b3";
                            "background" = "${base00}e6";
                            "element.background" = "${base01}b3";
                            "element.hover" = "${base02}cc";
                            "element.active" = "${base02}e6";
                            "element.selected" = "${base02}e6";
                            "element.disabled" = base01;
                            "drop_target.background" = "${base03}80";
                            "ghost_element.background" = transparent;
                            "ghost_element.hover" = base02;
                            "ghost_element.active" = base02;
                            "ghost_element.selected" = base02;
                            "ghost_element.disabled" = base01;
                            "text" = base05;
                            "text.muted" = base04;
                            "text.placeholder" = base03;
                            "text.disabled" = base03;
                            "text.accent" = base0D;
                            "icon" = base05;
                            "icon.muted" = base04;
                            "icon.disabled" = base03;
                            "icon.placeholder" = base04;
                            "icon.accent" = base0D;
                            "status_bar.background" = "${base01}cc";
                            "title_bar.background" = "${base01}cc";
                            "title_bar.inactive_background" = "${base00}cc";
                            "toolbar.background" = transparent;
                            "tab_bar.background" = transparent;
                            "tab.inactive_background" = transparent;
                            "tab.active_background" = base00;
                            "search.match_background" = "${base0A}66";
                            "search.active_match_background" = "${base09}66";
                            "panel.background" = "#00000020";
                            "panel.focused_border" = null;
                            "panel.overlay_background" = base00;
                            "pane.focused_border" = null;
                            "scrollbar.thumb.background" = "${base04}4c";
                            "scrollbar.thumb.hover_background" = base02;
                            "scrollbar.thumb.border" = base02;
                            "scrollbar.track.background" = transparent;
                            "scrollbar.track.border" = base01;
                            "editor.foreground" = base05;
                            "editor.background" = transparent;
                            "editor.gutter.background" = "${base00}55";
                            "editor.subheader.background" = base01;
                            "editor.active_line.background" = "${base01}80";
                            "editor.highlighted_line.background" = base01;
                            "editor.line_number" = base03;
                            "editor.active_line_number" = base05;
                            "editor.hover_line_number" = base04;
                            "editor.invisible" = base03;
                            "editor.wrap_guide" = "${base02}0d";
                            "editor.active_wrap_guide" = "${base02}1a";
                            "editor.document_highlight.read_background" = "${base0D}1a";
                            "editor.document_highlight.write_background" = "${base02}66";
                            "terminal.background" = transparent;
                            "terminal.foreground" = base05;
                            "terminal.bright_foreground" = base06;
                            "terminal.dim_foreground" = base03;
                            "terminal.ansi.black" = base00;
                            "terminal.ansi.bright_black" = base03;
                            "terminal.ansi.dim_black" = base00;
                            "terminal.ansi.red" = base07;
                            "terminal.ansi.bright_red" = base07;
                            "terminal.ansi.dim_red" = "${base07}bf";
                            "terminal.ansi.green" = base0B;
                            "terminal.ansi.bright_green" = base0B;
                            "terminal.ansi.dim_green" = "${base0B}bf";
                            "terminal.ansi.yellow" = base0A;
                            "terminal.ansi.bright_yellow" = base0A;
                            "terminal.ansi.dim_yellow" = "${base0A}bf";
                            "terminal.ansi.blue" = base0D;
                            "terminal.ansi.bright_blue" = base0D;
                            "terminal.ansi.dim_blue" = "${base0D}bf";
                            "terminal.ansi.magenta" = base0E;
                            "terminal.ansi.bright_magenta" = base0E;
                            "terminal.ansi.dim_magenta" = "${base0E}bf";
                            "terminal.ansi.cyan" = base0C;
                            "terminal.ansi.bright_cyan" = base0C;
                            "terminal.ansi.dim_cyan" = "${base0C}bf";
                            "terminal.ansi.white" = base05;
                            "terminal.ansi.bright_white" = base06;
                            "terminal.ansi.dim_white" = base04;
                            "link_text.hover" = base0D;
                            "version_control.added" = base0B;
                            "version_control.modified" = base0A;
                            "version_control.word_added" = "${base0B}59";
                            "version_control.word_deleted" = "${base0F}66";
                            "version_control.deleted" = base0F;
                            "version_control.conflict_marker.ours" = "${base0B}1a";
                            "version_control.conflict_marker.theirs" = "${base0D}1a";
                            "conflict" = base0A;
                            "conflict.background" = "${base0A}1a";
                            "conflict.border" = "${base0A}80";
                            "created" = base0B;
                            "created.background" = "${base0B}1a";
                            "created.border" = "${base0B}80";
                            "deleted" = base0F;
                            "deleted.background" = "${base0F}1a";
                            "deleted.border" = "${base0F}80";
                            "error" = base07;
                            "error.background" = "${base07}1a";
                            "error.border" = "${base07}80";
                            "hidden" = base03;
                            "hidden.background" = "${base02}1a";
                            "hidden.border" = base02;
                            "hint" = base0C;
                            "hint.background" = "${base0C}1a";
                            "hint.border" = "${base0C}80";
                            "ignored" = base03;
                            "ignored.background" = "${base02}1a";
                            "ignored.border" = base02;
                            "info" = base0D;
                            "info.background" = "${base0D}1a";
                            "info.border" = "${base0D}80";
                            "modified" = base0A;
                            "modified.background" = "${base0A}1a";
                            "modified.border" = "${base0A}80";
                            "predictive" = base03;
                            "predictive.background" = "${base03}1a";
                            "predictive.border" = "${base03}80";
                            "renamed" = base0D;
                            "renamed.background" = "${base0D}1a";
                            "renamed.border" = "${base0D}80";
                            "success" = base0B;
                            "success.background" = "${base0B}1a";
                            "success.border" = "${base0B}80";
                            "unreachable" = base04;
                            "unreachable.background" = "${base03}1a";
                            "unreachable.border" = base03;
                            "warning" = base0A;
                            "warning.background" = "${base0A}1a";
                            "warning.border" = "${base0A}80";
                            players = [
                                {
                                    cursor = base0D;
                                    background = "${base0D}20";
                                    selection = "${base0D}30";
                                }
                                {
                                    cursor = base0E;
                                    background = "${base0E}20";
                                    selection = "${base0E}30";
                                }
                                {
                                    cursor = base07;
                                    background = "${base07}20";
                                    selection = "${base07}30";
                                }
                                {
                                    cursor = base09;
                                    background = "${base09}20";
                                    selection = "${base09}30";
                                }
                                {
                                    cursor = base0A;
                                    background = "${base0A}20";
                                    selection = "${base0A}30";
                                }
                                {
                                    cursor = base0B;
                                    background = "${base0B}20";
                                    selection = "${base0B}30";
                                }
                                {
                                    cursor = base0C;
                                    background = "${base0C}20";
                                    selection = "${base0C}30";
                                }
                                {
                                    cursor = base0B;
                                    background = "${base0B}20";
                                    selection = "${base0B}30";
                                }
                            ];
                            syntax = {
                                attribute = {
                                    color = base0E;
                                    font_style = null;
                                    font_weight = null;
                                };
                                boolean = {
                                    color = base09;
                                    font_style = null;
                                    font_weight = null;
                                };
                                comment = {
                                    color = base03;
                                    font_style = "italic";
                                    font_weight = null;
                                };
                                "comment.doc" = {
                                    color = base03;
                                    font_style = "italic";
                                    font_weight = null;
                                };
                                constant = {
                                    color = base09;
                                    font_style = null;
                                    font_weight = null;
                                };
                                constructor = {
                                    color = base0D;
                                    font_style = null;
                                    font_weight = null;
                                };
                                embedded = {
                                    color = base08;
                                    font_style = null;
                                    font_weight = null;
                                };
                                emphasis = {
                                    color = base0B;
                                    font_style = "italic";
                                    font_weight = null;
                                };
                                "emphasis.strong" = {
                                    color = base0A;
                                    font_style = null;
                                    font_weight = 700;
                                };
                                enum = {
                                    color = base0A;
                                    font_style = null;
                                    font_weight = null;
                                };
                                function = {
                                    color = base0D;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "function.method" = {
                                    color = base0D;
                                    font_style = null;
                                    font_weight = null;
                                };
                                hint = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                keyword = {
                                    color = base0E;
                                    font_style = null;
                                    font_weight = null;
                                };
                                label = {
                                    color = base0D;
                                    font_style = null;
                                    font_weight = null;
                                };
                                link_text = {
                                    color = base0D;
                                    font_style = "underline";
                                    font_weight = null;
                                };
                                link_uri = {
                                    color = base0C;
                                    font_style = "underline";
                                    font_weight = null;
                                };
                                number = {
                                    color = base09;
                                    font_style = null;
                                    font_weight = null;
                                };
                                operator = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                predictive = {
                                    color = base03;
                                    font_style = "italic";
                                    font_weight = null;
                                };
                                preproc = {
                                    color = base0B;
                                    font_style = null;
                                    font_weight = null;
                                };
                                primary = {
                                    color = base08;
                                    font_style = null;
                                    font_weight = null;
                                };
                                property = {
                                    color = base08;
                                    font_style = null;
                                    font_weight = null;
                                };
                                punctuation = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "punctuation.bracket" = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "punctuation.delimiter" = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "punctuation.list_marker" = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "punctuation.special" = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                string = {
                                    color = base0B;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "string.escape" = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "string.regex" = {
                                    color = base0C;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "string.special" = {
                                    color = base0B;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "string.special.symbol" = {
                                    color = base0B;
                                    font_style = null;
                                    font_weight = null;
                                };
                                tag = {
                                    color = base0F;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "text.literal" = {
                                    color = base0B;
                                    font_style = null;
                                    font_weight = null;
                                };
                                title = {
                                    color = base0F;
                                    font_style = null;
                                    font_weight = 700;
                                };
                                type = {
                                    color = base0A;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "type.builtin" = {
                                    color = base0A;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "type.interface" = {
                                    color = base0A;
                                    font_style = "italic";
                                    font_weight = null;
                                };
                                "type.super" = {
                                    color = base0A;
                                    font_style = "italic";
                                    font_weight = null;
                                };
                                variable = {
                                    color = base08;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "variable.member" = {
                                    color = base08;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "variable.parameter" = {
                                    color = base09;
                                    font_style = null;
                                    font_weight = null;
                                };
                                "variable.special" = {
                                    color = base0F;
                                    font_style = "italic";
                                    font_weight = null;
                                };
                                variant = {
                                    color = base0A;
                                    font_style = null;
                                    font_weight = null;
                                };
                            };
                            "background.appearance" = "blurred";
                        };
                    }
                ];
            };
        };
    };
}
