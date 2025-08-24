{
    sources,
    lib,
    buildGoModule,
}: let
    inherit (sources.dgop) src pname date;
in
    buildGoModule {
        inherit pname src;
        version = "unstable-${date}";

        vendorHash = "sha256-+3o/Kg5ROSgp8IZfvU71JvbEgaiLasx5IAkjq27faLQ=";

        ldflags = ["-s" "-w"];

        installPhase = ''
            mkdir -p $out/bin
            cp $GOPATH/bin/cli $out/bin/dgop
        '';

        meta = {
            description = "API & CLI for System Resources";
            homepage = "https://github.com/AvengeMedia/dgop";
            license = lib.licenses.mit;
            maintainers = with lib.maintainers; [];
            mainProgram = "dgop";
        };
    }
