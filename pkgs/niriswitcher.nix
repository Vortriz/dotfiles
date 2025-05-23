{
    lib,
    buildPythonPackage,
    fetchFromGitHub,
    hatchling,
    pygobject3,
    gtk4-layer-shell,
    gtk4,
    libadwaita,
    gobject-introspection,
    wrapGAppsHook4,
}:
buildPythonPackage rec {
    pname = "niriswitcher";
    version = "0.5.2";
    pyproject = true;

    src = fetchFromGitHub {
        owner = "isaksamsten";
        repo = "niriswitcher";
        rev = version;
        hash = "sha256-jXnob/CJ3wrqYhbFRu7TnnnCrsKaDazD3t9lZoJVhdQ=";
    };

    build-system = [
        hatchling
    ];

    nativeBuildInputs = [
        gobject-introspection
        wrapGAppsHook4
    ];

    buildInputs = [
        gtk4-layer-shell
        gtk4
        libadwaita
    ];

    propagatedBuildInputs = [
        pygobject3
    ];

    dontWrapGApps = true;

    makeWrapperArgs = [
        "--prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [gtk4-layer-shell]}"
        "\${gappsWrapperArgs[@]}"
    ];

    meta = {
        description = "An application switcher for niri";
        homepage = "https://github.com/isaksamsten/niriswitcher";
        license = lib.licenses.mit;
        platform = lib.platforms.linux;
        mainProgram = "niriswitcher";
    };
}
