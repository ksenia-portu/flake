{ buildPythonPackage
, fetchPypi
, packaging
, setuptools
, lib, numpy, tqdm, scipy, torch
, gcc
, cudaPackages
, stdenv
, torchvision }:

buildPythonPackage rec {
  pname = "causal_conv1d";
  version = "1.2.0.post2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "3e35b96718b81a0b34c3717b5df06fd3ba44794079e40b34b719b152806acc1b";
  };

  propagatedBuildInputs = [ 
    torch 
    packaging
  ];
  
  # TODO FIXME
  doCheck = false;

  meta = with lib; {
    description = "Perceptual Similarity Metric and Dataset";
    homepage = "https://github.com/Dao-AILab/causal-conv1d";
  };
}
