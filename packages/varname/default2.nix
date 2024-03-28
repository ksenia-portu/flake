{ lib, python3Packages, fetchFromGitHub, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "varname";
  version = "0.13.0";
  format="pyproject";

  src = fetchFromGitHub {
    owner = "pwwang";
    repo = "python-varname";
    rev = "refs/tags/${version}";
    hash = "sha256-yc1vSUV9ENjOk3pFbEy4vdDuJYUpb8aBl0hJFHwlKpM="; # SHA256 hash of the source
  };  
  propagatedBuildInputs = with python3Packages; [
    poetry-core
    setuptools 
  ];

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
