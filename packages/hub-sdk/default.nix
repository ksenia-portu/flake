{ lib, python311Packages, fetchFromGitHub, fetchgit }: 

python311Packages.buildPythonPackage rec {
  pname = "hub-sdk";
  version = "v0.0.2";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/ultralytics/hub-sdk.git";
    rev = "862df4b9ef865a9db13c8396d345525466555c55";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-nUw+9wNqgxwDqvdcZYDGqGVGZcgnRwXHU6FXFxrkYSc=";  # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python311Packages; [
    requests
    setuptools 
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 




