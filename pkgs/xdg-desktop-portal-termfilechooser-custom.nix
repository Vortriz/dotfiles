{
    stdenv,
    fetchFromGitHub,
    lib,
    xdg-desktop-portal,
    ninja,
    meson,
    pkg-config,
    inih,
    systemd,
    scdoc,
}:
stdenv.mkDerivation {
    pname = "xdg-desktop-portal-termfilechooser";
    version = "1.0.5-1";

      src = fetchFromGitHub {
        owner = "Vortriz";
        repo = "xdg-desktop-portal-termfilechooser";
        rev = "817988fc0d41ec323f40c64ec0c320a475140a09";
        hash = "sha256-BvN0TKXgwcbCmc7bJVWtJ0qPR1KxAsiFrva57guyxZk=";
      };

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
