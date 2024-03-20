{ pkgs, lib, python311Packages, fetchFromGitHub, fetchgit }: 

let
  nexus-source = fetchFromGitHub {
    owner = "cnr-isti-vclab";
    repo = "nexus";
    rev = "283973ff1751c1941fb86916afe34c50736f275d";
    sha256 = "sha256-eoQHGZoJvcKKprDKGxeqo4PErrx/59wGQa/2H6RH+24=";
  };
in python311Packages.buildPythonPackage rec {
  pname = "pymeshlab";
  version = "v2023.12.post1";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/cnr-isti-vclab/PyMeshLab.git";
    rev = "1039d68ee58f997fb4421c006f6d8628d4123c05";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-Zl1S9hv6DTTYqiL5SGjdc8f65twAQkf/CLsfE/xfIJs=";  # SHA256 hash of the source
  };

  prePatch = ''
      mkdir -p src/meshlab/src/external/downloads/nexus-master/src/
      ln -s ${nexus-source} src/meshlab/src/external/downloads/nexus-master/src/corto
      substituteInPlace "setup.py" --replace "'numpy'" ""
    '';

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = with python311Packages; [ setuptools numpy ]; 

  configurePhase = ''
      mkdir build && cd build
      cmake ..  "-GNinja" "-DDCMAKE_INSTALL_PREFIX=./pymeshlab"  -DCMAKE_BUILD_TYPE=Release
    '';

  buildPhase = ''
      ninja
      ninja install
      ${python311Packages.pip}/bin/pip wheel .. -w wheels/
    '';

  #format = "other";

  pythonImportsCheck = ["pymeshlab"];

  installPhase = ''
      mkdir $out
      ${python311Packages.pip}/bin/pip install ./wheels/*.whl --no-index --no-warn-script-location --prefix="$out" --no-cache $pipInstallFlags
    '';

  src = src_repo;  # Adjust the path to your desired subdirectory

  nativeBuildInputs = with pkgs; [
      cmake
      python311Packages.pythonRelaxDepsHook
      ninja
      eigen
      cgal
      boost
      pkg-config
      stdenv.cc.cc.lib
      libGLU
      glew
      levmar
      qt5.wrapQtAppsHook
    ];
  buildInputs = with pkgs; [libGLU qt5.qtbase];
  
  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
