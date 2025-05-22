{
    lib,
    pkgs,
    ...
}: let
    inherit (lib) hasSuffix map filter;
in {
    home.packages =
        lib.filesystem.listFilesRecursive ./.
        |> map builtins.baseNameOf
        |> filter (f: hasSuffix ".nix" f && !hasSuffix "default.nix" f)
        |> map (f: pkgs.callPackage ./${f} {});
}
