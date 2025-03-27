{
    programs.scientific-fhs = {
        enable = true;
        enableNVIDIA = false;

        juliaVersions = [
            {
                version = "1.11.1";
                default = true;
            }
        ];
    };

    home.file = {
        ".julia/config/startup.jl".text = ''
            using Pkg

            if isfile("Project.toml") && isfile("Manifest.toml")
                Pkg.activate(".")
            end
        '';
    };
}