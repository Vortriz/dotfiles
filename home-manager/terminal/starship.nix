{
    pkgs,
    ...
}: {
    programs.starship = {
        enable = true;

        settings = (with builtins; fromTOML (
            readFile (
                fetchurl {
                    url = "https://starship.rs/presets/toml/nerd-font-symbols.toml";
                    sha256 = "sha256:1rf298kmiglm0mrd5ic1nalqs5si9i49xwrx6qqg881qlq6gx994";
                }
            )
        )) // {};
    };
}