{ buildPythonPackage
, fetchPypi
, packaging
, setuptools
, lib, numpy, tqdm, scipy, torch
, gcc12
, cudaPackages
, gcc12Stdenv
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
  
  #BUILD_CUDA_EXT = "1";
  #TORCH_CUDA_ARCH_LIST="6.1+PTX";
  CUDA_HOME = cudaPackages.cudatoolkit;
  CUDA_VERSION = cudaPackages.cudaVersion;
  
  nativeBuildInputs = lib.optionals gcc12Stdenv.isLinux (with cudaPackages; [
    setuptools
    cuda_nvtx
    cuda_nvcc
    cuda_cudart
    cuda_cupti
    cuda_nvrtc
    cudnn
    libcublas
    libcufft
    libcurand
    libcusolver
    libcusparse
    nccl
    gcc12
  ]);
  
  # TODO FIXME
  doCheck = false;

  meta = with lib; {
    description = "Perceptual Similarity Metric and Dataset";
    homepage = "https://github.com/Dao-AILab/causal-conv1d";
  };
}
