{
    inputs,
    modulesPath,
    pkgs,
    system,
    ...
}: {
    imports = [
        (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")

        inputs.nix-index-database.nixosModules.nix-index

        # cloudflare warp
        system/programs/warp.nix
    ];

    programs = {
        yazi.enable = true;
        fish.enable = true;
        direnv.enable = true;
        nix-index.enable = true;
        nix-index-database.comma.enable = true;
    };

    environment = {
        systemPackages = with pkgs; [
            fzf
            ookla-speedtest
            micro
            tealdeer
            nix-search-tv
            (
                (pkgs.callPackages home/terminal/nix-search-tv/sources/generated.nix {}).ns.src
                |> builtins.readFile
                |> pkgs.writeShellScriptBin "ns"
            )
        ];

        variables = {
            EDITOR = "micro";
        };
    };

    fonts.packages = [pkgs.maple-mono.Normal-NF-unhinted];

    users.defaultUserShell = pkgs.fish;

    networking.networkmanager.enable = true;

    # Nix settings
    nixpkgs = {
        config.allowUnfree = true;
    };

    nix = {
        settings = {
            # Enable flakes and new 'nix' command
            experimental-features = "nix-command flakes pipe-operators";
            warn-dirty = false;
        };
        channel.enable = false;
    };

    nixpkgs.hostPlatform = system;
}
