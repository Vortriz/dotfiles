[
    {
        bindings = {
            ctrl-q = null;
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
            ctrl-right = "editor::AcceptPartialEditPrediction";
        };
    }
    {
        context = "Workspace";
        bindings = {
            ctrl-shift-f = ["pane::DeploySearch" {excluded_files = "build.log, flake.lock";}];
        };
    }
]
