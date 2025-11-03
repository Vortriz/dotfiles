{
    config,
    pkgs,
    lib,
    ...
}: let
    ns =
        (pkgs.callPackages ../../sources/generated.nix {}).ns.src
        |> builtins.readFile
        |> pkgs.writeShellScriptBin "ns";
in {
    home.packages = [
        pkgs.nix-search-tv
        ns
    ];

    programs.niri.settings.binds."Mod+P" = config.niri-lib.open-tui {
        app = "ns";
        app-id = lib.getName pkgs.nix-search-tv;
    };
}
