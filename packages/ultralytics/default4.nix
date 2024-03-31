{ lib
, python3Packages
, scipy
, setuptools
, requests
, hub-sdk
, opencv-python
, opencv
, thop
, fetchFromGitHub
, fetchgit 
}: 

python3Packages.buildPythonPackage rec {
  pname = "ultralytics";
  version = "v8.1.0";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/ultralytics/ultralytics.git";
    rev = "808984c6cf32f4ac9cb28f52fd74d13b9d6ad6a0";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-nrvOos1Xx2Kb4iULAPN0/6GaVvrRdx0mLF7vAebjBQk=";  # SHA256 hash of the source
  };
    # TODO FIXME
  doCheck = false;

  # buildInputs for build and runtime dependencies, stuff you need to build the package and to run it.
  buildInputs = [
    #opencv-python
  #  opencv
  #  thop
  ];

  optional-dependencies = {
    complete = [  ];
  };

  #postPatch = ''    
  #  substituteInPlace pyproject.toml --replace "opencv-python" ""
  #'';

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python3Packages; [
    scipy
    setuptools
    requests
    torch
    torchvision
    tqdm 
    psutil 
    py-cpuinfo 
    thop 
    pandas 
    seaborn 
    hub-sdk 
    opencv-python
  #  opencv
    thop
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
