{ lib, python3Packages, fetchFromGitHub, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "zhipuai";
  version = "0.0.0";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/MetaGLM/zhipuai-sdk-python-v4.git";
    rev = "2a2943ec049107d5d179d6925838d3bf2c9ed731";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-NtsEI+Jh1qnTQLgH4Qwh8BGsfyC+uzF45E1dJ7hgljs=";  # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python3Packages; [
    #python3Packages; [  
    setuptools 
    httpx
    pydantic
    cachetools
    pyjwt
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
