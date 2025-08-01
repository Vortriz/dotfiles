{
    lib,
    fetchFromGitHub,
    rustPlatform,
    pkg-config,
    lz4,
    libxkbcommon,
    installShellFiles,
    scdoc,
    wayland-protocols,
    wayland-scanner,
}:
rustPlatform.buildRustPackage (_finalAttrs: {
    pname = "swww";
    version = "unstable-2025-06-23";

    src = fetchFromGitHub {
        owner = "LGFae";
        repo = "swww";
        rev = "805a355da574fed46e664606660e2499f02e2174";
        hash = "sha256-+sdV7NFueCeBLrsl7lrqzlG5tPNqDe/zlcIb8TYxQl8=";
    };

    cargoHash = "sha256-YH2gcy/8EtUmTHzwt38bBOFX3saN1wHIGQ5/eWqvSeM=";

    buildInputs = [
        lz4
        libxkbcommon
        wayland-protocols
        wayland-scanner
    ];

    doCheck = false; # Integration tests do not work in sandbox environment

    nativeBuildInputs = [
        pkg-config
        installShellFiles
        scdoc
    ];

    postInstall = ''
        for f in doc/*.scd; do
          local page="doc/$(basename "$f" .scd)"
          scdoc < "$f" > "$page"
          installManPage "$page"
        done

        installShellCompletion --cmd swww \
          --bash completions/swww.bash \
          --fish completions/swww.fish \
          --zsh completions/_swww
    '';

    meta = {
        description = "Efficient animated wallpaper daemon for wayland, controlled at runtime";
        homepage = "https://github.com/LGFae/swww";
        license = lib.licenses.gpl3;
        maintainers = with lib.maintainers; [
            mateodd25
            donovanglover
        ];
        platforms = lib.platforms.linux;
        mainProgram = "swww";
    };
})
