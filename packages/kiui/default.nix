{ lib, python311Packages, fetchFromGitHub, fetchgit }: 

python311Packages.buildPythonPackage rec {
  pname = "kiui";
  version = "0.2.5";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/ashawkey/kiuikit.git";
    rev = "f98e9687ba72ac0689e979da9dca62cda0a2a126";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-vl4AXtU21MTyBsyeT4yw2AmdBjc4LQXFA6UaNKEdJ9M=";  # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [  python311Packages.setuptools ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
