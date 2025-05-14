{pkgs, ...}: {
    imports = [
        # keep-sorted start by_regex=\.nix$
        ./julia.nix

        ./vscode
        # keep-sorted end
    ];

    home.packages = with pkgs; [
        # keep-sorted start
        texliveFull
        typst
        # keep-sorted end
    ];
}
