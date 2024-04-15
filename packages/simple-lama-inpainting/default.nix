{ lib
, buildPythonPackage
, setuptools
, poetry-core
, fire
, numpy
, opencv-python
, opencv-python-headless
, pillow
, torch
, torchvision
, fetchFromGitHub, fetchgit }: 

buildPythonPackage rec {
  pname = "simple-lama-inpainting";
  version = "0.1.2";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/ksenia-portu/simple-lama-inpainting.git";
    rev = "adc79ce4b55c71a7852e7ac49a04808911182020";
    sha256 = "sha256-vuQIduGi33abwldf6i7h+ObDERky4igWJFfE0LPPXRQ=";
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [  
    setuptools
    poetry-core
    fire       
    numpy      
    opencv-python    
    opencv-python-headless 
    pillow     
    torch      
    torchvision 
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  postPatch = ''    
    substituteInPlace pyproject.toml --replace "opencv-python" "opencv"
  '';
  
  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
