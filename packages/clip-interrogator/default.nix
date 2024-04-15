{ lib
, python3Packages
#, imageio
#, scipy
#, typing-extensions
#, numpy
, torch
, torchvision
, pillow
, requests
, safetensors
, tqdm
, open-clip-torch
, accelerate
, transformers
#, poetry-core
, fetchFromGitHub
, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "clip-interrogator";
  version = "0.6.0";
  format="pyproject";

  src = fetchFromGitHub {
    owner = "pharmapsychotic";
    repo = "clip-interrogator";
    rev = "refs/tags/v${version}";
    hash = "sha256-cccVl689afyBf5EDrlGQAfjUJbxE3CoOqoWrHtPRhPM=";
  };
  

  nativeBuildInputs = with python3Packages; [
    setuptools
    torch
    torchvision
    pillow
    requests
    safetensors
    tqdm
    open-clip-torch
    accelerate
    transformers  
   ];

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
