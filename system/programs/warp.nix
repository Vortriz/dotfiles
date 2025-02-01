{
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        cloudflare-warp
    ];

    systemd = {
        packages = with pkgs; [ cloudflare-warp ];
        targets.multi-user.wants = [ "warp-svc.service" ];
    };
}