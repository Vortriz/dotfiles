{
    programs.sherlock = {
        enable = true;

        style = with builtins;
            fetchurl {
                url = "https://raw.githubusercontent.com/Skxxtz/sherlock/refs/heads/main/resources/main.css";
                sha256 = "sha256-GeR0luiZWo1GFjxRpPqbaNOi5++g8EHPU2qauTvWmiE=";
            }
            |> readFile
            |> (f: f + readFile ./extra.css);
    };
}
