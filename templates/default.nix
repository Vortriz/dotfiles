{
    julia = {
        path = ./julia;
        description = "Scientific dev environment with Julia";
    };

    minimal-sci-env = {
        path = ./minimal-sci-env;
        description = "Minimal scientific env";
    };

    python = {
        path = ./python;
        description = "Scientific dev environment with Python (via uv)";
    };

    typst-presentation = {
        path = ./typst-presentation;
        description = "Typst presentation using custom Touying theme";
    };

    # taken from https://nixos.wiki/wiki/Rust#Installation_via_rustup
    rust = {
        path = ./rust;
        description = "Rust flake with rustup";
    };
}
