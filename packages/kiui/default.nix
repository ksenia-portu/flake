{ lib
, python3Packages
, varname
, objprint
, fetchFromGitHub
, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "kiui";
  version = "0.2.5";
  format="pyproject";

  src = fetchFromGitHub {
    owner = "ashawkey";
    repo = "kiuikit";
    rev = "refs/tags/${version}";
    hash = "sha256-vl4AXtU21MTyBsyeT4yw2AmdBjc4LQXFA6UaNKEdJ9M=";  # SHA256 hash of the source
  };
  

  nativeBuildInputs = with python3Packages; [
    lazy-loader
    varname
    objprint
    setuptools 
  ];

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
