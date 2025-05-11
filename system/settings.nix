{
    config,
    pkgs,
    ...
}: let
    inherit (config.var) defaultLocale extraLocale hostname timeZone;
in {
    # keep-sorted start block=yes newline_separated=yes
    documentation = {
        man.enable = false;
        info.enable = false;
    };

    environment.variables = {
        EDITOR = "micro";

        # For OpenGL applications in shell.nix/flake.nix (looking at you GLMakie)
        LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    };

    fonts.packages = with pkgs; [
        # keep-sorted start block=yes
        (google-fonts.override {
            fonts = [
                "Inter"
                "Overpass"
                "Rubik"
                "Hanken Grotesk"
                "Open Sans"
            ];
        })
        HelveticaNeueCyr
        SFMono
        font-awesome
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        roboto
        source-sans-pro
        # keep-sorted end
    ];

    hardware = {
        bluetooth.enable = true;

        graphics = {
            enable = true;

            # For steam (wine)
            enable32Bit = true;
        };
    };

    i18n = {
        inherit defaultLocale;
        extraLocaleSettings = {
            LC_ADDRESS = extraLocale;
            LC_IDENTIFICATION = extraLocale;
            LC_MEASUREMENT = extraLocale;
            LC_MONETARY = extraLocale;
            LC_NAME = extraLocale;
            LC_NUMERIC = extraLocale;
            LC_PAPER = extraLocale;
            LC_TELEPHONE = extraLocale;
            LC_TIME = extraLocale;
        };
    };

    networking = {
        hostName = hostname;

        # Enables wireless support via wpa_supplicant.
        # wireless.enable = true;

        # proxy = {
        # default = "http://172.16.2.250:3128";
        # noProxy = "127.0.0.1,localhost,internal.domain";
        # };

        networkmanager.enable = true;

        firewall.enable = true;
    };

    nix = {
        gc.automatic = false; # because nh
        optimise.automatic = true;
    };

    security = {
        # for sound and something else too
        rtkit.enable = true;

        # idk
        polkit.enable = true;

        # oxidizing sudo
        sudo-rs.enable = true;
        sudo.enable = false;
    };

    system.rebuild.enableNg = true;

    time = {
        inherit timeZone;
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
    # keep-sorted end
}
