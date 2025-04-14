{
    config,
    inputs,
    outputs,
    ...
}: let
    username = config.var.username;
in {
    imports = [
        # Import home-manager's NixOS module
        inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
        extraSpecialArgs = {inherit inputs outputs;};
        users = {
            # Import your home-manager configuration
            ${username} = import ../home/home.nix;
        };
        backupFileExtension = "backup";
    };
}
