{ lib
, buildPythonPackage
, toPythonModule
, buildPackages
, fetchFromGitHub
, cmake
, glm
, gcc12
, clang
, cacert
, git
, symlinkJoin
, ninja
, setuptools
, cudaPackages
, which
, pybind11
, torch
#, stdenv
, gcc12Stdenv
, fetchgit
}:

buildPythonPackage rec {
  pname = "diff-gaussian-rasterization";
  version = "0.0.0";
  pyproject = true;
  #format = "pyproject";

  src = fetchFromGitHub {
    owner = "ashawkey";
    repo = "diff-gaussian-rasterization";
    rev = "d986da0d4cf2dfeb43b9a379b6e9fa0a7f3f7eea";
    hash = "sha256-VosVYSjhXCXy3xCrwmumPgyY6baVk6wXAZXk+tP1LD0=";
#"sha256-SKSSpEa9ydi4+aLPO4cD/N/nYnM9Gd5Wz4nNNvBKb58=";
  };
  #TORCH_CUDA_ARCH_LIST="6.1+PTX"; 
  TORCH_CUDA_ARCH_LIST = "6.0 6.1 6.1+PTX 7.2+PTX 7.5+PTX"; 
  BUILD_CUDA_EXT = "1"; 
  CUDA_HOME = cudaPackages.cudatoolkit;
  CUDA_VERSION = cudaPackages.cudaVersion;

  buildInputs = lib.optionals gcc12Stdenv.isLinux (with cudaPackages; [
    cuda_nvtx
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
    which
    ninja
  ]);
  
  propagatedBuildInputs = [
    setuptools
    torch
    ninja
    which

   ];
 
  nativeBuildInputs = [
    which
    ninja
    #rocmPackages.clr
  ];
   
  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
}
#)
