{ lib
, python3Packages
, imageio
, scipy
, typing-extensions
, numpy
, poetry-core
, fetchFromGitHub
, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "colour-science";
  version = "0.4.4";
  format="pyproject";

  src = fetchFromGitHub {
    owner = "colour-science";
    repo = "colour";
    rev = "refs/tags/v${version}";
    hash = "sha256-o+hSC64vMR41PCXYbi5p/G9jhQZ1+zCINNeCfrhQKrg=";
#"sha256-vl4AXtU21MTyBsyeT4yw2AmdBjc4LQXFA6UaNKEdJ9M=";  # SHA256 hash of the source
  };
  

  nativeBuildInputs = with python3Packages; [
    typing-extensions
    scipy
    numpy
    imageio
    poetry-core
    setuptools 
  ];

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
