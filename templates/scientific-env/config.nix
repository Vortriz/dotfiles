{pkgs, ...}: {
    # Change accordingly
    system = "x86_64-linux"; # other examples are "x86_64-darwin" and "aarch64-linux"
    shell = "fish";

    python = {
        enable = true;
        package = pkgs.python312;
        env = {};

        # Python tools that you would usually install via `uv tool install` should also be go here
        extraPackages =
            (with pkgs; [
                nodejs # for using copilot in marimo
                ruff # for formatting
            ])
            ++ (with pkgs.python312Packages; [
                python-lsp-server # for LSP features in marimo
            ]);
    };

    julia = {
        enable = true;
        package = pkgs.julia-bin; # It is suggested to use julia-bin
        env = {
            JULIA_NUM_THREADS = 16;
        };

        # Packages that you want available in the Julia FHS environment (NOT the julia packages themselves)
        extraPackages = with pkgs; [
            xwayland-satellite # For X11 applications in Wayland
        ];
    };

    additionalPackages = with pkgs; [
        typst
    ];

    env = {};
}
