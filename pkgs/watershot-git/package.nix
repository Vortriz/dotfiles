{
    sources,
    lib,
    rustPlatform,
    pkg-config,
    fontconfig,
    libxkbcommon,
    vulkan-loader,
    grim,
    wayland,
    libGL,
    makeWrapper,
}: let
    inherit (sources.watershot) src pname date;
in
    rustPlatform.buildRustPackage {
        inherit pname src;
        version = "unstable-${date}";

        cargoHash = "sha256-BftZZClQbLPox5betSPoBddTLX2VU7OwgmMPUfW+4+w=";

        nativeBuildInputs = [
            pkg-config
            makeWrapper
        ];

        buildInputs = [
            fontconfig
            libxkbcommon
            vulkan-loader
            libGL
            wayland
        ];

        postFixup = ''
            patchelf --add-rpath ${vulkan-loader}/lib $out/bin/watershot
            patchelf --add-rpath ${libGL}/lib $out/bin/watershot

            wrapProgram $out/bin/watershot \
              --add-flags "-g \"${grim}/bin/grim\""
        '';

        meta = {
            description = "A simple wayland native screenshot tool";
            homepage = "https://github.com/Kirottu/watershot";
            license = lib.licenses.gpl3Only;
            mainProgram = "watershot";
        };
    }
