{
    lib,
    pkgs,
    ...
}: {
    home.packages =
        lib.packagesFromDirectoryRecursive {
            inherit (pkgs) callPackage;
            directory = ./.;
        }
        |> lib.attrValues
        |> lib.filter (lib.isDerivation);
}
