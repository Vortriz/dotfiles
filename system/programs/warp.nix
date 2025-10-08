{pkgs, ...}: {
    environment.systemPackages = [pkgs.cloudflare-warp];

    systemd = {
        packages = [pkgs.cloudflare-warp];
        targets.multi-user.wants = ["warp-svc.service"];
    };
}
