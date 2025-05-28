{lib, ...}: {
    imports = with lib;
        filesystem.listFilesRecursive ./.
        |> filter (f: !hasSuffix "default.nix" f);
}
