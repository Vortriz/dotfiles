{
    pkgs,
    ...
}: {
    programs.yazi.plugins = let
        official-plugins-src = pkgs.fetchFromGitHub {
            owner = "yazi-rs";
            repo = "plugins";
            rev = "92f78dc6d0a42569fd0e9df8f70670648b8afb78";
            hash = "sha256-mqo71VLZsHmgTybxgqKNo9F2QeMuCSvZ89uen1VbWb4=";
        };

        # the ones to be installed from official-plugins repo
        official-plugins = [
            "smart-enter"
            "jump-to-char"
            "smart-filter"
            "mount"
        ];

        other-plugins-src = {
            glow = pkgs.fetchFromGitHub {
                owner = "Reledia";
                repo = "glow.yazi";
                rev = "c76bf4fb612079480d305fe6fe570bddfe4f99d3";
                hash = "sha256-DPud1Mfagl2z490f5L69ZPnZmVCa0ROXtFeDbEegBBU=";
            };

            mediainfo = pkgs.fetchFromGitHub {
                owner = "boydaihungst";
                repo = "mediainfo.yazi";
                rev = "447fe95239a488459cfdbd12f3293d91ac6ae0d7";
                hash = "sha256-U6rr3TrFTtnibrwJdJ4rN2Xco4Bt4QbwEVUTNXlWRps=";
            };

            ouch = pkgs.fetchFromGitHub {
                owner = "ndtoan96";
                repo = "ouch.yazi";
                rev = "ce6fb75431b9d0d88efc6ae92e8a8ebb9bc1864a";
                hash = "sha256-oUEUGgeVbljQICB43v9DeEM3XWMAKt3Ll11IcLCS/PA=";
            };

            first-non-directory = "${pkgs.fetchFromGitHub {
                owner = "lpanebr";
                repo = "yazi-plugins";
                rev = "ca18a2cfb893e3608997c9de54acced124373871";
                hash = "sha256-v+EmMbrccAlzeR9rhmlFq0f+899l624EhWx1DFz+qzc=";
            }}/first-non-directory.yazi";

            yamb = pkgs.fetchFromGitHub {
                owner = "h-hg";
                repo = "yamb.yazi";
                rev = "22af0033be18eead7b04c2768767d38ccfbaa05b";
                hash = "sha256-NMxZ8/7HQgs+BsZeH4nEglWsRH2ibAzq7hRSyrtFDTA=";
            };

            what-size = pkgs.fetchFromGitHub {
                owner = "Vortriz";
                repo = "what-size.yazi";
                rev = "f4b8b5a5e0aea60ef6350c0100763b5c900c82a7";
                hash = "sha256-sSeXL9/SOuPKIeZR2ntLP0HGSLBobbrzdTgpikA5jMg=";
            };

            restore = pkgs.fetchFromGitHub {
                owner = "boydaihungst";
                repo = "restore.yazi";
                rev = "5d228847775678070f437f8a0c4f4746820a5f33";
                hash = "sha256-Hxkvmf6iQysjWHaOjm2Q1WOYWyo2K6woTw1rlnpxCyM=";
            };

            file-navigation-wraparound = pkgs.fetchFromGitHub {
                owner = "Vortriz";
                repo = "file-navigation-wraparound.yazi";
                rev = "6484727aff772278b2d2d54f54cf8ce18575aa73";
                hash = "sha256-QdTMciYOuQMRDRNwLesvepgtzI91JXfHAcgUbH46Gyw=";
            };

            auto-layout = pkgs.fetchFromGitHub {
                owner = "josephschmitt";
                repo = "auto-layout.yazi";
                rev = "626a6016283558b9766fe305e76b694dd9fb6156";
                hash = "sha256-sGyy1tLDqR1aNrxQBHcswqussorIkQX70rsR2JoC1Lo=";
            };

            custom-shell = pkgs.fetchFromGitHub {
                owner = "AnirudhG07";
                repo = "custom-shell.yazi";
                rev = "6b4550a1b18afbb7ef328ebf54d81de24101288e";
                hash = "sha256-deLbUM4J/pDrLdKeEp62GJ+CFdwsSwOUiX85KuCRStc=";
            };

            office = pkgs.fetchFromGitHub {
                owner = "macydnah";
                repo = "office.yazi";
                rev = "bcd9e9e78835c96eb2bb8b8841e4753704b99b17";
                hash = "sha256-rZas/oMNI6H5lXOixDQcL/dQC+J9VCFrOOIIjjLDUc4=";
            };
        };

        other-plugins = builtins.attrNames other-plugins-src;
    in
        builtins.listToAttrs (map (name: {
            name = name;
            value = "${official-plugins-src}/${name}.yazi";
        }) official-plugins) // builtins.listToAttrs (map (name: {
            name = name;
            value = other-plugins-src.${name};
        }) other-plugins);

    # dependencies
    home.packages = with pkgs; [
        # glow-yazi
        glow

        # mediainfo-yazi
        mediainfo
        ffmpeg-full

        # ouch-yazi
        ouch

        # restore-yazi
        trash-cli

        # office
        poppler-utils
        libreoffice

        # drag and drop
        ripdrag

        # mount-yazi
        udisks
    ];
}