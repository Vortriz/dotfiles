# taken from https://github.com/misumisumi/flakes/blob/f488a0d7308d0ac3b47ac12d9d557cb109148145/pkgs/zotero-addons/default.nix
{
    fetchgit,
    fetchurl,
    fetchFromGitHub,
    dockerTools,
    lib,
    stdenv,
}: let
    buildZoteroXpiAddon = {
        stdenv,
        pname,
        version,
        src,
        addonId,
        homepage,
        description,
        license,
        ...
    }:
        stdenv.mkDerivation {
            inherit pname version src;

            preferLocalBuild = true;
            allowSubstitutes = true;

            passthru = {inherit addonId;};

            buildCommand = ''
                dst="$out/share/zotero/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
                mkdir -p "$dst"
                install -v -m644 "$src" "$dst/${addonId}.xpi"
            '';
            meta = {
                inherit version homepage description;
                license = lib.licenses.${license};
            };
        };
    addonSources = import ./_sources/generated.nix {
        inherit fetchgit fetchurl fetchFromGitHub dockerTools;
    };
in
    lib.mapAttrs (
        _name: source:
            buildZoteroXpiAddon {
                inherit stdenv;
                inherit (source) pname version src addonId homepage description license;
            }
    )
    addonSources
