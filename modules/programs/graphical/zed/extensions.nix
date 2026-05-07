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
                "nix"
                "qml"
                "quarto"
                "scss"
                "svelte"
                "toml"
                "typst"
                # keep-sorted end
            ];

            extraPackages = with pkgs; [
                # keep-sorted start
                alejandra
                kdePackages.qtdeclarative
                # keep-sorted end
            ];

            userSettings = {
                auto_install_extensions = lib.attrsets.genAttrs extensions (_: false);

                lsp =
                    ([
                        # keep-sorted start
                        "just-lsp"
                        "lua-language-server"
                        "nil"
                        "nixd"
                        "package-version-server"
                        "rust-analyzer"
                        "svelte-language-server"
                        "tailwindcss-language-server"
                        "texlab"
                        "tinymist"
                        "ty"
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
                        tombi.binary = {
                            path = lib.getExe pkgs.tombi;
                            arguments = ["lsp"];
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
    };
}
