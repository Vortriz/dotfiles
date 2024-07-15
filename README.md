# SETUP (Notes to self)

1. Boot into iso
2. Connect to non-institute wifi
3. Install warp
    - Put this into configuration.nix
    ```
    environment.systemPackages = with pkgs; [ cloudflare-warp ]

    systemd = {
        packages = with pkgs; [ cloudflare-warp ];
        targets.multi-user.wants = [ "warp-svc.service" ];
    };
    ```
    - Then run `sudo nixos-rebuild test`
    - Then run the following commands
    ```
    warp-cli registration new
    warp-cli connect
    ```
4. Procced to install NixOS
5. After installation, setup flakes with by adding `nix.settings.experimental-features = [ "nix-command" "flakes" ];` in `configuration.nix`
6. Download the dotfiles and add the current `hardware-configuration.nix` into the appropriate place
7. Follow the steps 2-3 again.  