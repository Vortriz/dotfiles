{pkgs, ...}: {
    environment.variables = {
        EDITOR = "micro";

        # For nh
        FLAKE = "$HOME/dotfiles/";

        # For OpenGL applications in shell.nix/flake.nix (looking at you GLMakie)
        LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    };

    fonts.packages = with pkgs; [
        HelveticaNeueCyr
        SFMono

        font-awesome
        roboto
        source-sans-pro

        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono

        (google-fonts.override {fonts = ["Inter" "Overpass" "Rubik" "Hanken Grotesk" "Open Sans"];})
    ];

    hardware = {
        bluetooth.enable = true;

        graphics = {
            enable = true;

            # For steam (wine)
            enable32Bit = true;
        };
    };

    environment.systemPackages = with pkgs; [
        blueman
    ];

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

    networking = {
        hostName = "nixos";

        # Enables wireless support via wpa_supplicant.
        # wireless.enable = true;

        # proxy = {
        #     default = "http://172.16.2.250:3128";
        #     noProxy = "127.0.0.1,localhost,internal.domain";
        # };

        networkmanager.enable = true;

        firewall.enable = true;
    };

    nix = {
        gc.automatic = false; # because nh
        optimise.automatic = true;
    };

    security = {
        pam.services = {
            kwallet = {
                name = "kdewallet";
                enableKwallet = false;
            };
        };

        # for sound and something else too
        rtkit.enable = true;

        # idk
        polkit.enable = true;
    };

    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 16 * 1024;
        }
    ];

    time = {
        timeZone = "Asia/Kolkata";
        hardwareClockInLocalTime = true;
    };

    virtualisation = {
        # following configuration is added only when building VM with build-vm
        vmVariant.virtualisation = {
            memorySize = 4096;
            cores = 4;
        };

        # for distrobox
        podman = {
            enable = true;

            dockerCompat = true;
        };
    };
}
