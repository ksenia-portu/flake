{ lib
, python3Packages
, typeguard
, fetchFromGitHub, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "torchtyping";
  version = "0.1.4";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/patrick-kidger/torchtyping.git";
    rev = "1f3749c5b5617ec6b6449e98ad9ae3fb6645ef54";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-URhTRExWGajRg3AoBPZtNoAtgbt33xzTyYw/aPRIfM4="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python3Packages; [
    setuptools 
    typeguard
    torch
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
