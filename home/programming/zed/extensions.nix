{
    pkgs,
    lib,
    ...
}: {
    programs.zed-editor = rec {
        extensions = [
            # keep-sorted start
            "astro"
            "fish"
            "harper"
            "julia"
            "just"
            "latex"
            "modern-icons"
            "nix"
            "qml"
            "scss"
            "typst"
            # keep-sorted end
        ];

        extraPackages = with pkgs; [
            # keep-sorted start
            alejandra
            astro-language-server
            harper
            kdePackages.qtdeclarative
            nixd
            nodejs_latest
            package-version-server
            ruff
            rust-analyzer
            texlab
            tinymist
            ty
            # keep-sorted end
        ];

        userSettings = {
            auto_install_extensions = lib.attrsets.genAttrs extensions (_: false);

            lsp =
                ([
                    # keep-sorted start
                    "nixd"
                    "package-version-server"
                    "rust-analyzer"
                    "tailwindcss-language-server"
                    "texlab"
                    "tinymist"
                    # keep-sorted end
                ]
                |> map (name: {
                    ${name}.binary = {
                        path = lib.getExe pkgs.${name};
                    };
                })
                |> lib.mergeAttrsList)
                // {
                    # keep-sorted start block=yes
                    astro-language-server.binary = {
                        path = lib.getExe pkgs.astro-language-server;
                        arguments = ["--stdio"];
                    };
                    harper.binary = {
                        path = lib.getExe pkgs.harper;
                        arguments = ["--stdio"];
                    };
                    qml.binary = {
                        path = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
                        arguments = ["-E"];
                    };
                    ruff.binary = {
                        path = lib.getExe pkgs.ruff;
                        arguments = ["server"];
                    };
                    tailwindcss-language-server.binary = {
                        path = lib.getExe pkgs.tailwindcss-language-server;
                        arguments = ["--stdio"];
                    };
                    ty.binary = {
                        path = lib.getExe pkgs.ty;
                        arguments = ["server"];
                    };
                    # keep-sorted end
                };
        };
    };
}
