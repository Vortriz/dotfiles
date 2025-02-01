{
    pkgs,
    ...
}: {
    programs.nix-ld = {
        enable = true;

        libraries = with pkgs; [
            # Add any missing dynamic libraries for unpackaged
            # programs here, NOT in environment.systemPackages
        ];
    };
}