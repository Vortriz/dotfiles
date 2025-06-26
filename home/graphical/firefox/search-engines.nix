{
    programs.firefox.profiles.default.search = {
        force = true;
        default = "google";
        order = ["searxng" "google" "mynixos" "github"];

        engines = let
            engine = args: {
                icon = "${args.icon}";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@${args.alias}"];
                urls = [
                    {
                        template = "${args.surl}";
                        params = [
                            {
                                name = "q";
                                value = "{searchTerms}";
                            }
                        ];
                    }
                ];
            };
        in {
            # keep-sorted start block=yes newline_separated=yes
            "amazondotcom-us".metaData.hidden = true;

            "bing".metaData.hidden = true;

            "github" = engine rec {
                url = "https://github.com";
                icon = "${url}/favicon.ico";
                alias = "gh";
                surl = "${url}/search";
            };

            "google" = engine rec {
                url = "htttps://google.com";
                icon = "${url}/favicon.ico";
                alias = "google";
                surl = "${url}/search";
            };

            "mynixos" = engine rec {
                url = "https://mynixos.com";
                icon = "${url}/favicon.ico";
                alias = "nix";
                surl = "${url}/search";
            };

            "searxng" = engine rec {
                url = "https://search.bus-hit.me";
                icon = "${url}/favicon.ico";
                alias = "xng";
                surl = "${url}/search";
            };
            # keep-sorted end
        };
    };
}
