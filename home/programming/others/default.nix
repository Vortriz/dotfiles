{pkgs, ...}: {
    home.packages = with pkgs; [
        # keep-sorted start
        texliveFull
        typst
        # keep-sorted end
    ];
}
