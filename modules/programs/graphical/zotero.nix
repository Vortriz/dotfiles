{ inputs, ... }: {
    unify = {
        nixos = {
            nixpkgs.config.permittedInsecurePackages = [
                "firefox-esr-140-bin-unwrapped-140.17.0esr"
            ];
        };

        home =
            {
                lib,
                hostConfig,
                pkgs,
                ...
            }:
            {
                imports = [ inputs.vpkgs.homeModules.zotero ];

                programs.zotero = {
                    enable = true;

                    profiles.default = {
                        settings =
                            let
                                path = "${hostConfig.dirs.storage}/nonlinear-vault/00.literature/articles";
                                bbt-citekey-format = "creators(n = 1, name = \"%(f)s%(g)s\").condense + year + shorttitle(2,2)";
                            in
                            {
                                # keep-sorted start
                                "browser.aboutConfig.showWarning" = false;
                                "extensions.update.autoUpdateDefault" = false;
                                "extensions.zotero.attachmentRenameTemplate" =
                                    ''{{ if {{ authors match="[^,]+,[^,]+,[^,]+" }} }}{{ authors max="1" suffix=" et al." }}{{ else }}{{ authors max="3" join=", " }}{{ endif }} - {{ year }} - {{ title }}'';
                                "extensions.zotero.baseAttachmentPath" = path;
                                "extensions.zotero.export.quickCopy.setting" = "export=8a2f0d30-0b73-4f2c-8b5b-7c1a9e3f2d4e"; # "Better Hayagriva"
                                "extensions.zotero.showAttachmentFilenames" = true;
                                "extensions.zotero.translators.better-bibtex.baseAttachmentPath" = path;
                                "extensions.zotero.translators.better-bibtex.citekeyFormat" = bbt-citekey-format;
                                "extensions.zotero.translators.better-bibtex.citekeyFormatEditing" = bbt-citekey-format;
                                "extensions.zotero.translators.better-bibtex.path.git" = lib.getExe pkgs.git;
                                "extensions.zotero.translators.better-bibtex.skipFields" = "file";
                                "extensions.zotmoov.dst_dir" = path;
                                # keep-sorted end
                            };

                        extensions = with inputs.vpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.zoteroAddons; [
                            # keep-sorted start
                            zotero-better-bibtex
                            zotero-scihub
                            zotlit
                            zotmoov
                            # keep-sorted end
                        ];
                    };
                };
            };
    };
}
