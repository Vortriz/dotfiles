{
    programs.starship = {
        enable = true;

        settings = with builtins;
            fetchurl {
                url = "https://starship.rs/presets/toml/nerd-font-symbols.toml";
                sha256 = "sha256:1wrzcsfgf0r9fsy8w144jhm5y6zrbafsx5qcldsfks1y105jxl1j";
            }
            |> readFile
            |> fromTOML;
    };
}
