{ buildPythonPackage
, fetchPypi
#, packaging
#, setuptools
, lib
#, numpy, tqdm, scipy, torch
#, cudaPackages
#, torchvision 
}:

buildPythonPackage rec {
  pname = "token-count";
  version = "0.2.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-9kYphaXKK5JcyGmTLDovZPV9keeNn13ATf33F8IGKTo=";
  };

  propagatedBuildInputs = [ 
    #torch 
    #packaging
  ];
  
  
  # TODO FIXME
  doCheck = false;

  meta = with lib; {
    description = "Perceptual Similarity Metric and Dataset";
    homepage = "https://github.com/Dao-AILab/causal-conv1d";
  };
}
