{pkgs, ...}: let
    ns =
        builtins.fetchurl {
            url = "https://raw.githubusercontent.com/3timeslazy/nix-search-tv/refs/heads/main/nixpkgs.sh";
            sha256 = "sha256-/usZX16ept4bXAf10jggeVwOn8B7Rs2dV48F9Jc0dbk=";
        }
        |> builtins.readFile
        |> pkgs.writeShellScriptBin "ns";
in {
    home.packages = [
        pkgs.nix-search-tv
        ns
    ];
}
