{
    config,
    inputs,
    outputs,
    ...
}: let
    inherit (config.var) username;
in {
    imports = [
        # Import home-manager's NixOS module
        inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
        extraSpecialArgs = {inherit inputs outputs;};

        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;

        users = {
            # Import your home-manager configuration
            ${username} = import ../home/home.nix;
        };
    };
}
