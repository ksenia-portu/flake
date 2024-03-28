{ lib
, buildPythonPackage 
, fetchFromGitHub
, setuptools
, matplotlib
, opencv-python # https://pypi.org/project/opencv-python/
, pillow
, pyyaml
, requests
, scipy
, torch
, torchvision
, tqdm
, psutil
, py-cpuinfo
, thop
, pandas
, seaborn
, hub-sdk
}:

buildPythonPackage {
  pname = "ultralytics";
  version = "v8.1.0";

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ultralytics";
    repo = "ultralytics";
    rev = "808984c6cf32f4ac9cb28f52fd74d13b9d6ad6a0";
    hash = "sha256-nrvOos1Xx2Kb4iULAPN0/6GaVvrRdx0mLF7vAebjBQk=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    matplotlib
    opencv-python # https://pypi.org/project/opencv-python/
    pillow
    pyyaml
    requests
    scipy
    torch
    torchvision
    tqdm
    psutil
    py-cpuinfo
    thop
    pandas
    seaborn
    hub-sdk
  ];

  postPatch = ''    
    substituteInPlace pyproject.toml --replace "opencv-python" "opencv"
  '';


  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
}
