{
    lib,
    stdenvNoCC,
    fetchFromGitHub,
    cosmic-ext-alternative-startup,
    bash,
    dbus,
}:
stdenvNoCC.mkDerivation {
    pname = "cosmic-ext-niri";
    version = "unstable-2025-04-02";

    src = fetchFromGitHub {
        owner = "drakulix";
        repo = "cosmic-ext-extra-sessions";
        rev = "66e065728d81eab86171e542dad08fb628c88494";
        hash = "sha256-dqbDV5nxYgGp1aV+9jCWY92wjnllKwN1TEI8BADd+z8=";
        sparseCheckout = [ "niri" ];
    };

    passthru.providedSessions = [ "cosmic-ext-niri" ];

    installPhase = ''
        install -Dm644 $src/niri/cosmic-ext-niri.desktop -t $out/share/wayland-sessions
        install -Dm755 $src/niri/start-cosmic-ext-niri -t $out/bin
    '';

    postFixup = ''
        substituteInPlace "$out/share/wayland-sessions/cosmic-ext-niri.desktop" \
            --replace-fail "Exec=/usr/local/bin/start-cosmic-ext-niri" "Exec=start-cosmic-ext-niri"

        patchShebangs $out/bin
        substituteInPlace "$out/bin/start-cosmic-ext-niri" \
            --replace-fail "/usr/bin/dbus-run-session" "${dbus}/bin/dbus-run-session" \
            --replace-fail "/usr/bin/cosmic-session" "cosmic-session"
    '';
}