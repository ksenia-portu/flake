{ lib
, setuptools
, python311Packages
, fetchFromGitHub
, fetchgit 
}: 

python311Packages.buildPythonPackage rec {
  pname = "thop";
  version = "0.1.1";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/Lyken17/pytorch-OpCounter.git";
    rev = "43c064afb71383501e41eaef9e8c8407265cf77f"; # Specify the specific commit, tag, or branch
    sha256 = "sha256-erjTFFfP8G+EIfEXWb2VfThau3tdkTZqI02nwE3rgzs=";  # SHA256 hash of the source
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
