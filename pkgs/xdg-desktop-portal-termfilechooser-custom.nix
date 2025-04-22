{
    callPackages,
    stdenv,
    lib,
    xdg-desktop-portal,
    ninja,
    meson,
    pkg-config,
    inih,
    systemd,
    scdoc,
}: let
    source = (callPackages ./sources/generated.nix {}).xdg-desktop-portal-termfilechooser;
in
    stdenv.mkDerivation {
        inherit (source) src pname;
        version = "unstable-${source.date}";

        nativeBuildInputs = [
            meson
            ninja
            pkg-config
            scdoc
        ];

        buildInputs = [
            xdg-desktop-portal
            inih
            systemd
        ];

        mesonFlags = ["-Dsd-bus-provider=libsystemd"];

        meta = with lib; {
            description = "xdg-desktop-portal backend for choosing files with your favorite file chooser";
            homepage = "https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser";
            license = licenses.mit;
            platforms = platforms.linux;
            maintainers = with lib.maintainers; [];
            mainProgram = "xdg-desktop-portal-termfilechooser";
        };
    }
