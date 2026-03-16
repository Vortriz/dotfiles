{inputs, ...}: {
    unify.home = {
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

        xdg.configFile."nix-search-tv/config.json".text = lib.toJSON {
            indexes = ["nixpkgs" "nixos" "home-manager" "nur" "noogle"];
        };

        wayland.windowManager.niri.settings.binds."Mod+P" = {
            spawn-sh = "xdg-terminal-exec --app-id=nix-search-tv ${lib.getExe ns}";
            _props.hotkey-overlay-title = "Open nix-search-tv";
        };
    };
}
