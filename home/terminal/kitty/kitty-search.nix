{pkgs, ...}: let
    ks = pkgs.fetchFromGitHub {
        owner = "trygveaa";
        repo = "kitty-kitten-search";
        rev = "992c1f3d220dc3e1ae18a24b15fcaf47f4e61ff8";
        hash = "sha256-Xy4dH2fzEQmKfqhmotVDEszuTqoISONGNfC1yfcdevs=";
    };
in {
    xdg.configFile = {
        "kitty/search.py".source = "${ks}/search.py";
        "kitty/scroll_mark.py".source = "${ks}/scroll_mark.py";
    };

    programs.kitty.settings."map ctrl+f" = "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
}
