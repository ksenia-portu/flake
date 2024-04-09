{ lib, python3Packages, fetchFromGitHub, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "gaussian-splatting";
  version = "0.0.0";
  #format="pyproject";
  pyproject = true;
  #format = "pyproject";

  src_repo = fetchgit {
    url = "https://github.com/graphdeco-inria/gaussian-splatting.git";
    rev = "472689c0dc70417448fb451bf529ae532d32c095"; # Specify the specific commit, tag, or branch
    sha256 = "sha256-/lwHxZv8vX+C8l2MS755xfSyBREFDIKsv1oqu+mr5wY="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [  python3Packages.setuptools ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
