{
    unify.nixos = {
        services.resolved.enable = true;

        programs.openvpn3.enable = true;

        boot.kernelModules = [ "tun" ];
    };
}
