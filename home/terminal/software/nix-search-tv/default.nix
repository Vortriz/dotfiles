{
    inputs,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) system;
    ns =
        builtins.fetchurl {
            url = "https://raw.githubusercontent.com/3timeslazy/nix-search-tv/refs/heads/main/nixpkgs.sh";
            sha256 = "sha256-/usZX16ept4bXAf10jggeVwOn8B7Rs2dV48F9Jc0dbk=";
        }
        |> builtins.readFile
        |> pkgs.writeShellScriptBin "ns";
in {
    programs.nix-search-tv = {
        enable = true;
        package = inputs.nix-search-tv.packages.${system}.default;
    };

    home.packages = [ns];
}
