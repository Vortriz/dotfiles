{
    programs.fish = {
        enable = true;

        shellAliases =
        let
            ff = ( path: type: nth:  "fd . '/mnt/${path}' -t ${type} | fzf --delimiter='/' --with-nth ${nth}.. --wrap" );
        in {
            "ffv" = ff "SECONDARY/nonlinear vault" "f" "6";
            "ffp" = ff "PRIMARY" "f" "5";
            "ffs" = ff "SECONDARY" "f" "5";
            "fdp" = ff "PRIMARY" "d" "5";
            "fds" = ff "SECONDARY" "d" "5";
        } //
        builtins.mapAttrs ( alias: x: "open $(ff${x})" ) { "ofp" = "p"; "ofs" = "s"; "ofv" = "v"; } //
        builtins.mapAttrs ( alias: x: "cd $(fd${x})" ) { "cdp" = "p"; "cds" = "s"; };
    };
}