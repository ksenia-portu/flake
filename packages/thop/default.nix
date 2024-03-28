{ lib
, setuptools
, torch
, python3Packages
, fetchFromGitHub
}: 

python3Packages.buildPythonPackage rec {
  pname = "thop";
  version = "0.1.1";
  format="pyproject";

  src = fetchFromGitHub {
    owner = "ksenia-portu";
    repo = "pytorch-OpCounter";
    rev = "7d1f7fddda6e7aeaeff4e55d6a8b79079ed1fef6";
    hash = "sha256-WgM3Kg/Em6631WXM9kmRtuKnxWSiwlBMz4k/BH/GxZE=";# SHA256 hash of the source
  };
  doCheck = false;   

  propagatedBuildInputs = [  
    setuptools
    torch 
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "opencv-python" "opencv"
  '';  
  
  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
