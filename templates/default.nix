{
    default = {
        path = ./default;
        description = "A simple flake";
    };

    julia = {
        path = ./julia;
        description = "Scientific dev environment with Julia";
        welcomeText = "Run `nix run nixpkgs#nvfetcher` once";
    };

    python = {
        path = ./python;
        description = "Scientific dev environment with Python (via uv)";
    };

    minimal-sci-env = {
        path = ./minimal-sci-env;
        description = "Scientific env";
    };

    typst-presentation = {
        path = ./typst-presentation;
        description = "Typst presentation using custom Touying theme";
    };
}
