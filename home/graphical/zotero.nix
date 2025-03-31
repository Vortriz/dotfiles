{
    inputs,
    pkgs,
    ...
}: {
    programs.zotero = {
        enable = true;
        profiles.default = {
            settings = let
                path = "/mnt/SECONDARY/nonlinear vault/03 - Resources/Articles"; # TODO: global vars
                bbt-citekey-format = "auth.lower + year";
            in {
                "extensions.update.autoUpdateDefault" = false;
                "extensions.zotero.baseAttachmentPath" = path;
                "extensions.zotero.attachmentRenameTemplate" = ''{{ if {{ authors match="[^,]+,[^,]+,[^,]+" }} }}{{ authors max="1" suffix=" et al." }}{{ else }}{{ authors max="3" join=", " }}{{ endif }} - {{ year }} - {{ title }}'';
                "extensions.zotero.translators.better-bibtex.citekeyFormat" = bbt-citekey-format;
                "extensions.zotero.translators.better-bibtex.citekeyFormatEditing" = bbt-citekey-format;
                "extensions.zotero.translators.better-bibtex.baseAttachmentPath" = path;
                "extensions.zotmoov.dst_dir" = path;
            };

            extensions = map (ext: inputs.misumisumi-flakes.packages."${pkgs.system}"."zotero-addons.${ext}") [
                "zotero-better-bibtex"
                "zotero-scipdf"
                "zotero-zotmoov"
            ];
        };
    };
}
