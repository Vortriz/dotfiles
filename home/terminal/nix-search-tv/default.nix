{
    config,
    pkgs,
    lib,
    ...
}: let
    ns =
        builtins.fetchurl {
            url = "https://raw.githubusercontent.com/3timeslazy/nix-search-tv/refs/heads/main/nixpkgs.sh";
            sha256 = "sha256:0k7vkd83zgbwr3fgkf4nszwaq3ab9344w4nq9krj75fpla1vawxz";
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
