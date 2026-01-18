{
    unify.home = {
        lib,
        pkgs,
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
                "lua"
                "modern-icons"
                "nix"
                "qml"
                "quarto"
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
                lua-language-server
                nixd
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
                        "lua-language-server"
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
                        harper-ls.binary = {
                            path = lib.getExe pkgs.harper;
                            arguments = ["--stdio"];
                        };
                        qmljs.binary = {
                            path = lib.getExe' pkgs.kdePackages.qtdeclarative "qmlls";
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
                        # keep-sorted end
                    };
            };
        };
    };
}
