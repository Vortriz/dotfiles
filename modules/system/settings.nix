{ inputs, config, pkgs, ... }:
    
{
    boot = {
        loader = {
            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 10;
            efi.canTouchEfiVariables = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;
    };

    networking = {
        hostName = "nixos";
        # Enables wireless support via wpa_supplicant.
        # wireless.enable = true;
        # proxy.default = "http://172.16.2.250:3128";
        # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        # Enable networking
        networkmanager.enable = true;
        # Open ports in the firewall.
        # firewall.allowedTCPPorts = [ ... ]; 
        # firewall.allowedUDPPorts = [ ... ];
        firewall.enable = true;
    };

    time = {
        timeZone = "Asia/Kolkata";
        hardwareClockInLocalTime = true;
    };

    i18n = {
        defaultLocale = "en_IN";
        extraLocaleSettings = {
            LC_ADDRESS = "en_IN";
            LC_IDENTIFICATION = "en_IN";
            LC_MEASUREMENT = "en_IN";
            LC_MONETARY = "en_IN";
            LC_NAME = "en_IN";
            LC_NUMERIC = "en_IN";
            LC_PAPER = "en_IN";
            LC_TELEPHONE = "en_IN";
            LC_TIME = "en_IN";
        };
    };

    services = {
        # Enable the X11 windowing system.
        xserver.enable = true;
        # Enable the KDE Plasma Desktop Environment.
        displayManager.sddm.enable = true;
        desktopManager.plasma6.enable = true;

        # Configure keymap in X11
        xserver.xkb = {
            layout = "us";
            variant = "";
        };

        # Enable CUPS to print documents.
        printing.enable = true;
        
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            # If you want to use JACK applications
            # jack.enable = true;
            # use the example session manager (no others are packaged yet so this is enabled by default,
            # no need to redefine it in your config for now)
            # media-session.enable = true;
        };

        # List services that you want to enable:
        # create_ap.enable = true;
        # create_ap.settings = {
        #     INTERNET_IFACE = "eth0";
        #     PASSPHRASE = "12345678";
        #     SSID = "My Wifi Hotspot";
        #     WIFI_IFACE = "wlan0";
        # };

        # Enable the OpenSSH daemon.
        # openssh.enable = true;
    };

    security.polkit.extraConfig = ''
    
    // See the polkit(8) man page for more information
    // about configuring polkit.

    // Allow udisks2 to mount devices without authentication
    // for users in the "wheel" group.
    polkit.addRule(function(action, subject) {
        if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
            action.id == "org.freedesktop.udisks2.filesystem-mount") &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
    '';

    security.pam.services.kwallet = {
        name = "kdewallet";
        enableKwallet = true;
    };


    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    nix.gc.automatic = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    #Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    systemd.packages = [ pkgs.cloudflare-warp ];
    systemd.targets.multi-user.wants = [ "warp-svc.service" ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #     enable = true;
    #     enableSSHSupport = true;
    # };

    # For steam (wine)
    hardware.opengl.driSupport32Bit = true;

    users.users.rishi = {
        isNormalUser = true;
        description = "Rishi";
        extraGroups = [ "networkmanager" "wheel" ];
    };
}