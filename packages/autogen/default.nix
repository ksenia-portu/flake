{ lib, python3Packages, fetchFromGitHub, fetchgit
#, openai
#, diskcache
#, termcolor
, flaml
#, numpy
#, python-dotenv
#, tiktoken
#, pydantic
#, docker
}: 

python3Packages.buildPythonPackage rec {
  pname = "autogen";
  version = "v0.2.21";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/microsoft/autogen.git";
    rev = "6fbb9e8274dc92643347e64ee5fb1eee5fe24b64";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-q0tus7d6nx6+PqyP+AWbqjYneFefRwATJpRmaKoZBj8="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python3Packages; [ 
    setuptools
    openai
    diskcache
    termcolor
    #flaml
    numpy
    python-dotenv
    tiktoken
    flaml
    docker 
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
