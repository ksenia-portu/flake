{ lib
, buildPythonPackage
, setuptools 
, fetchFromGitHub, fetchgit }: 

buildPythonPackage rec {
  pname = "deforum";
  version = "0.0.0";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/XmYx/deforum-studio.git";
    rev = "82248ee33ab576b440eb17daad054677ee33af99"; 
# Specify the specific commit, tag, or branch
    sha256 = "sha256-LluW41EXRNJGRorVH4lP3WQotboXwR21+c8FkLKWf18=";
# SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [  
    setuptools 
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
