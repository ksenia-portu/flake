{ lib, python311Packages, fetchFromGitHub, fetchgit }: 

python311Packages.buildPythonPackage rec {
  pname = "varname";
  version = "0.13.0";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/pwwang/python-varname.git";
    rev = "ea1ec82fa608d13cb6d44f849b9df3c6a7c90501";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-yc1vSUV9ENjOk3pFbEy4vdDuJYUpb8aBl0hJFHwlKpM="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python311Packages; [
    poetry-core
    setuptools 
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
