{
    config,
    pkgs,
    lib,
    ...
}: let
    ns =
        builtins.fetchurl {
            url = "https://raw.githubusercontent.com/3timeslazy/nix-search-tv/refs/heads/main/nixpkgs.sh";
            sha256 = "sha256:1z5jgi27yrisy3rwrba01kj2chpq68zdr5g5aalh5y5xd0rv0j3c";
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
