{inputs, ...}: {
    unify = {
        nixos = {
            nixpkgs.overlays = [inputs.nur-vortriz.overlays.zoteroAddons];
        };

        home = {
            lib,
            hostConfig,
            pkgs,
            ...
        }: {
            imports = [inputs.nur-vortriz.homeModules.zotero];

            programs.zotero = {
                enable = true;

                profiles.default = {
                    settings = let
                        path = "${hostConfig.dirs.storage}/nonlinear-vault/03.resources/articles";
                        bbt-citekey-format = "auth.lower + year";
                    in {
                        # keep-sorted start
                        "browser.aboutConfig.showWarning" = false;
                        "extensions.update.autoUpdateDefault" = false;
                        "extensions.zotero.attachmentRenameTemplate" = ''{{ if {{ authors match="[^,]+,[^,]+,[^,]+" }} }}{{ authors max="1" suffix=" et al." }}{{ else }}{{ authors max="3" join=", " }}{{ endif }} - {{ year }} - {{ title }}'';
                        "extensions.zotero.baseAttachmentPath" = path;
                        "extensions.zotero.translators.better-bibtex.baseAttachmentPath" = path;
                        "extensions.zotero.translators.better-bibtex.citekeyFormat" = bbt-citekey-format;
                        "extensions.zotero.translators.better-bibtex.citekeyFormatEditing" = bbt-citekey-format;
                        "extensions.zotero.translators.better-bibtex.path.git" = lib.getExe pkgs.git;
                        "extensions.zotmoov.dst_dir" = path;
                        # keep-sorted end
                    };

                    extensions = with pkgs.zoteroAddons; [
                        # keep-sorted start
                        zotero-better-bibtex
                        zotero-scipdf
                        zotmoov
                        # keep-sorted end
                    ];
                };
            };
        };
    };
}
