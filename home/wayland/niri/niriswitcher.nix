{
    inputs,
    osConfig,
    ...
}: let
    inherit (osConfig.var) system;
in {
    imports = [inputs.nur-vortriz.legacyPackages.${system}.homeManagerModules.niriswitcher];

    programs.niriswitcher.enable = true;
}
