{
    lib,
    python3Packages,
    fetchFromGitHub,
}:
python3Packages.buildPythonApplication {
    pname = "dunefetch";
    version = "unstable-2025-07-16";
    pyproject = true;

    src = fetchFromGitHub {
        owner = "datavorous";
        repo = "dunefetch";
        rev = "7f20d7ae89e0fbc3052d82a45f11eab4e2640091";
        hash = "sha256-T8hjTbrfO7ai31eBSgV+rOjw3gFcATa+2PnDzHHkSNk=";
    };

    build-system = with python3Packages; [
        setuptools
        wheel
    ];

    dependencies = with python3Packages; [
        psutil
    ];

    pythonImportsCheck = [
        "dunefetch"
    ];

    meta = {
        description = "Neofetch + falling sand engine for your terminal";
        homepage = "https://github.com/datavorous/dunefetch";
        license = lib.licenses.mit;
        maintainers = with lib.maintainers; [];
        mainProgram = "dunefetch";
    };
}
