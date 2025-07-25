{
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) storageDir;
in {
    programs.zotero = {
        enable = true;

        profiles.default = {
            settings = let
                path = "${storageDir}/nonlinear-vault/03.resources/articles";
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

            extensions = with pkgs.callPackages ./plugins.nix {}; [
                # keep-sorted start
                zotero-better-bibtex
                zotero-scipdf
                zotero-zotmoov
                # keep-sorted end
            ];
        };
    };
}
