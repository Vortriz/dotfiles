{
    unify.home = {
        programs.zed-editor = {
            mutableUserKeymaps = false;

            userKeymaps = [
                {
                    bindings = {
                        ctrl-q = null;
                        alt-ctrl-o = ["projects::OpenRecent" {"create_new_window" = false;}];
                        ctrl-p = "file_finder::Toggle";
                        ctrl-shift-p = "command_palette::Toggle";
                    };
                }
                {
                    context = "Terminal";
                    bindings = {
                        ctrl-shift-f = "pane::DeploySearch";
                        ctrl-s = ["terminal::SendKeystroke" "ctrl-s"];
                    };
                }
                {
                    context = "Editor && edit_prediction";
                    bindings = {
                        ctrl-right = "editor::AcceptNextWordEditPrediction";
                    };
                }
                {
                    context = "Workspace";
                    bindings = {
                        ctrl-shift-f = ["pane::DeploySearch" {excluded_files = "build.log, flake.lock";}];
                    };
                }
            ];
        };
    };
}
