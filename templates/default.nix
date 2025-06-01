{
    # taken from https://pyproject-nix.github.io/uv2nix/usage/hello-world.html
    uv2nix = {
        path = ./uv2nix;
        description = "uv2nix Flake";
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
        welcomeText = "It is suggested to change settings in `config.nix` before proceeding.";
    };
}
