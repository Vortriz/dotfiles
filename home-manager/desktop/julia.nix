{
    programs.scientific-fhs = {
        enable = true;
        juliaVersions = [
            {
                version = "1.11.1";
                default = true;
            }
        ];
        enableNVIDIA = false;
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