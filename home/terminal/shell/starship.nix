{
    programs.starship = {
        enable = true;

        settings = with builtins;
            fromTOML (readFile (fetchurl {
                url = "https://starship.rs/presets/toml/nerd-font-symbols.toml";
                sha256 = "05yvqiycb580mnym7q8lvk1wcvpq7rc4jjqb829z3s82wcb9cmbr";
            }));
    };
}
