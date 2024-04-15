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
  pname = "typing";
  version = "3.10.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-E7StIR9U3b+T5ZAamWex4HcgwdG3jVlqxqQ5ZBqhsTA=";
  };

  propagatedBuildInputs = [ 
    #torch 
    #packaging
  ];
  
  
  # TODO FIXME
  doCheck = false;

  meta = with lib; {
    description = "Typing – Type Hints for Python";
    homepage = "https://github.com/python/typing";
  };
}
