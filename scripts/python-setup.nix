{
    pkgs,
    ...
}: {
    home.packages = [
        (pkgs.writers.writeFishBin "python-setup" {} ''
            echo "Going to make a Python development environment..."

            echo "Specify python version ('y' for default 3.10.8):"
            read py_ver
            if test $py_ver = y
                set py_ver "3.10.8"
            end

            echo "Specify python libraries to install (space separated list):"
            read libs

            devenv init
            devenv inputs add nixpkgs-python github:cachix/nixpkgs-python --follows nixpkgs

            set contents "{ pkgs, lib, config, inputs, ... }:

            {
                languages.python = {
                    enable = true;
                    version = \"$py_ver\";

                    venv = {
                        enable = true;
                        requirements = ./requirements.txt;
                    };
                };

                packages = with pkgs; [
                    git
                ];
            }"

            echo $contents > devenv.nix
            string split ' ' $libs >> requirements.txt

            devenv shell
        '')
    ];
}
