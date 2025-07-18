{
    minimal-sci-env = {
        path = ./minimal-sci-env;
        description = "Minimal scientific env";
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

    scientific-env = {
        path = ./scientific-env;
        description = "Scientific dev environment with Julia and Python (via uv)";
    };
}
