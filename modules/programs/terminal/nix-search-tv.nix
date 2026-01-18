{inputs, ...}: {
    unify.home = {
        config,
        lib,
        pkgs,
        ...
    }: let
        ns =
            inputs.nix-search-tv-script
            |> builtins.readFile
            |> pkgs.writeShellScriptBin "ns";
    in {
        home.packages = [
            pkgs.nix-search-tv
            ns
        ];

        programs.niri.settings.binds."Mod+P" = {
            action = config.lib.niri.actions.spawn-sh "xdg-terminal-exec --app-id=nix-search-tv ${lib.getExe ns}";
            hotkey-overlay.title = "Open nix-search-tv";
        };
    };
}
