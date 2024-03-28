{ lib, python3Packages, fetchFromGitHub, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "color-matcher";
  version = "v0.5.0";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/hahnec/color-matcher.git";
    rev = "40ea94e6c36cd93d119e97875e80eb409ada1422";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-e2LJtxi9Pto5gJ8HENut7lLCI9BNJC1AViaoaeXZyGo="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python3Packages; [
    numpy
    imageio
    ddt
    docutils
    setuptools 
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
