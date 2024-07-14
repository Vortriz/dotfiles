{
    pkgs,
    ...
}: {
    systemd = {
        packages = [ pkgs.cloudflare-warp ];
        targets.multi-user.wants = [ "warp-svc.service" ];
    };
}