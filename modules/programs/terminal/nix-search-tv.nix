{
    unify.home = {
        config,
        pkgs,
        ...
    }: let
        ns =
            (pkgs.callPackages ../../../_sources/generated.nix {}).ns.src
            |> builtins.readFile
            |> pkgs.writeShellScriptBin "ns";
    in {
        home.packages = [
            pkgs.nix-search-tv
            ns
        ];

        programs.niri.settings.binds."Mod+P" = {
            action = config.lib.niri.actions.spawn-sh "ns";
            hotkey-overlay.title = "Open nix-search-tv";
        };
    };
}
