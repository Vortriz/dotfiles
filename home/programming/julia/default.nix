{
    xdg.dataFile."julia/config/startup.jl".text = ''
        using Pkg

        if isfile("Project.toml") && isfile("Manifest.toml")
            Pkg.activate(".")
        end
    '';
}
