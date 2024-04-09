{ lib, python3Packages, fetchFromGitHub, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "flaml";
  version = "v2.1.2";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/microsoft/FLAML.git";
    rev = "3de0dc667e8cd3f8e200f2b01f959be3a356774e";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-uhmfmRC/g6w0NX5KqLS4BM/fnQl/6u2xibA4rho4tFs="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python3Packages; [
    setuptools 
    numpy
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
