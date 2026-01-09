{
    unify.home = {
        programs.firefox.profiles.default.search = {
            force = true;
            default = "google";
            order = ["nix" "google" "github" "noogle"];

            engines = {
                # keep-sorted start block=yes newline_separated=yes
                "amazondotcom-us".metaData.hidden = true;

                "bing".metaData.hidden = true;

                "bookmarks".metaData.hidden = true;

                "ddg".metaData.hidden = true;

                "github" = {
                    urls = [{template = "https://github.com/search?q={searchTerms}&type=code";}];
                    icon = "https://github.com/favicon.ico";
                    definedAliases = ["@gh"];
                };

                "nix" = {
                    urls = [{template = "https://github.com/search?q=lang%3Anix+{searchTerms}&type=code";}];
                    icon = "https://nixos.org/favicon.ico";
                    definedAliases = ["@nix"];
                };

                "noogle" = {
                    urls = [{template = "https://noogle.dev/q?term={searchTerms}";}];
                    icon = "https://noogle.dev/favicon.png";
                    definedAliases = ["@ng"];
                };

                "perplexity".metaData.hidden = true;

                "wikipedia".metaData.hidden = true;
                # keep-sorted end
            };
        };
    };
}
