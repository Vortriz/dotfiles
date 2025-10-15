{
    config,
    lib,
    pkgs,
    ...
}: let
    inherit (config.var) defaultLocale extraLocale hostname monospaceFont timeZone;
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

    fonts.packages = with pkgs;
        [
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
        ]
        ++ [monospaceFont];

    hardware = {
        bluetooth = {
            enable = true;

            powerOnBoot = false;
        };

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
        # for sound and something else too
        rtkit.enable = true;

        pam.services = {
            login.enableGnomeKeyring = true;
            gdm.enableGnomeKeyring = true;
            hyprlock = {};
        };

        # oxidizing sudo
        sudo-rs.enable = true;
        sudo.enable = false;

        # espanso
        wrappers.espanso = {
            capabilities = "cap_dac_override+p";
            owner = "root";
            group = "root";
            source = lib.getExe (
                pkgs.espanso-wayland.overrideAttrs (old: {
                    patchPhase =
                        old.patchPhase or ""
                        + ''
                            substituteInPlace espanso/src/cli/daemon/mod.rs \
                                --replace-fail \
                                  'std::env::current_exe().expect("unable to obtain espanso executable location");' \
                                  'std::ffi::OsString::from("/run/wrappers/bin/espanso");'
                        '';
                })
            );
        };
    };

    system.rebuild.enableNg = true;

    time = {
        inherit timeZone;
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
