# SETUP (Notes to self)

1. Boot into ISO
2. Connect to non-institute wifi
3. Procced to install NixOS and make sure to label the root partition as ROOT and boot partition as SYSTEM
4. After installation, install warp
    - Put this into `/etc/nixos/configuration.nix`

    ```
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [ pkgs.cloudflare-warp ];

    systemd = {
      packages = [ pkgs.cloudflare-warp ];
      targets.multi-user.wants = [ "warp-svc.service" ];
    };
    ```

    - Rebuild with `sudo nixos-rebuild test`
    - Then run the following commands

    ```
    warp-cli register
    warp-cli connect
    ```

5. Enter nix shell having git with `nix-shell -p git`. Then clone dotfiles with `git clone https://github.com/Vortriz/dotfiles` and exit the shell.
6. Then cd into `dotfiles` and enter `nix develop --extra-experimental-features "flakes nix-command"`. Run `bash post-install`.
7. Run `just deploy` to finish off.

## Post install

1. Rekey Agenix

# FIX broken setup

1. Boot into ISO and connect to wifi
2. Mount root partition like `mount <ROOT> /mnt` and boot as `mount <BOOT> /mnt/boot`
3. Then `nixos-enter`
4. Fix whatever you messed up
5. Rebuild `boot` with `--option sandbox false` option
