{
    config,
    pkgs,
    lib,
    ...
}: let
    ns =
        builtins.fetchurl {
            url = "https://raw.githubusercontent.com/Vortriz/nix-search-tv/refs/heads/main/nixpkgs.sh";
            sha256 = "sha256-VMfQFvvgAw8b58GA8H53K08wKv1Q0GsUKmgLJbTARDI=";
        }
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
