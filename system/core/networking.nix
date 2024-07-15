{
    networking = {
        hostName = "nixos";

        # Enables wireless support via wpa_supplicant.
        # wireless.enable = true;

        # proxy = {
        #     default = "http://172.16.2.250:3128";
        #     noProxy = "127.0.0.1,localhost,internal.domain";
        # };
        
        # Enable networking
        networkmanager.enable = true;

        firewall = {
            enable = true;
            # Open ports in the firewall.
            # allowedTCPPorts = [ ... ];
            # allowedUDPPorts = [ ... ];
        };
    };
}