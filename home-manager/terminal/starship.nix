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
                    sha256 = "sha256:0k1xk78qa07bl3ml8l88bxbk0wskkrh4ym34my10dj1lrkm16k5a";
                }
            )
        )) // {};
    };
}