{ lib, python3Packages, fetchFromGitHub, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "evalidate";
  version = "v2.0.2";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/yaroslaff/evalidate.git";
    rev = "70cb8a796245eabc7d105f8eabd2243e8e092640";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-uFWjC5GHm5PuPJtIyoXS4Cy2azJACZPnRfW88hjCJbA="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [  python3Packages.setuptools ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
