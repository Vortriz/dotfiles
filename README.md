# SETUP (Notes to self)

1. Boot into iso
2. Connect to non-institute wifi
3. Procced to install NixOS
4. After installation, install warp
    - Put this into `/etc/nixos/configuration.nix`
    ```
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [ cloudflare-warp ];

    systemd = {
      packages = with pkgs; [ cloudflare-warp ];
      targets.multi-user.wants = [ "warp-svc.service" ];
    };
    ```
    - Rebuild with `sudo nixos-rebuild test`
    - Then run the following commands
    ```
    warp-cli register
    warp-cli connect
    ```
5. Setup flakes by adding `nix.settings.experimental-features = [ "nix-command" "flakes" ];` to `/etc/nixos/configuration.nix` and rebuild with `sudo nixos-rebuild test`
6. Download the [dotfiles](https://github.com/Vortriz/nixos-dots) to `Home` and rebuild with `sudo nixos-rebuild switch --flake ~/dotfiles/`, then reboot
7. Delete `dotfiles` locally and clone [dotfiles](https://github.com/Vortriz/nixos-dots)
8. Add mounts
    - Get relevant partitions by running `sudo blkid`
    - Put this into `hardware-configuration.nix`
    ```
    fileSystems."/run/media/<LABEL>" =
    { device = "/dev/disk/by-uuid/<UUID>";
    };
    ```
    - Rebuild with `nh os test`
9. Run `bash post-install` from `dotfiles`
10. Run `bash rebuild` to finish off
