{
    inputs,
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.var) dotfilesDir system;
in {
    programs.anifetch = {
        enable = true;
        package = inputs.anifetch.packages.${system}.default;
    };

    programs.fish.shellAliases = {
        fetch = ''anifetch -ff -f ${dotfilesDir}/assets/fetch.mp4 -r 10 -W 100 -c "--symbols wide --fg-only"'';
    };

    programs.fastfetch = {
        enable = true;
        settings = import ./config.nix {inherit lib osConfig;};
    };
}
