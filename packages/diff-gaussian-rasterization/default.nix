{ lib
, buildPythonApplication
, buildPythonPackage
, toPythonModule
, python3Packages
, buildPackages
, fetchFromGitHub
, cmake
, glm
, gcc12
, ninja
, setuptools
, cudaPackages
, which
, torch
#, stdenv
, gcc12Stdenv
, fetchgit
}:

let
  inherit (torch) cudaCapabilities cudaPackages cudaSupport;
  inherit (cudaPackages) backendStdenv;
in buildPythonApplication ( rec {
#in buildPythonPackage ( rec {
#in toPythonModule (gcc12Stdenv.mkDerivation rec {  
  pname = "diff-gaussian-rasterization";
  version = "0.0.0";
  #pyproject = true;
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ashawkey";
    repo = "diff-gaussian-rasterization";
    rev = "d986da0d4cf2dfeb43b9a379b6e9fa0a7f3f7eea";
    hash = "sha256-VosVYSjhXCXy3xCrwmumPgyY6baVk6wXAZXk+tP1LD0=";
  };
  #TORCH_CUDA_ARCH_LIST="6.1+PTX"; 
  #TORCH_CUDA_ARCH_LIST = "6.0 6.1 6.1+PTX 7.2+PTX 7.5+PTX"; 
  BUILD_CUDA_EXT = "1"; 
  CUDA_HOME        = cudaPackages.cudatoolkit;
  CUDA_VERSION     = cudaPackages.cudaVersion;
  CUDAToolkit_ROOT = cudaPackages.cudatoolkit;
  CUDACXX = "${cudaPackages.cudatoolkit}/bin/nvcc";

  
  buildInputs = lib.optionals gcc12Stdenv.isLinux (with cudaPackages; [
    cuda_cudart
    cmake
    glm
    ninja
  ]);

  
  preBuild = ''
    export CUDA_HOME=${cudaPackages.cuda_nvcc}
  '';

  #preConfigure = ''
  #''
  ## NOTE: We essentially override the compilers provided by stdenv because we don't have a hook
  ##   for cudaPackages to swap in compilers supported by NVCC.
  #+ lib.optionalString cudaSupport ''
  #  export CC=${backendStdenv.cc}/bin/cc
  #  export CXX=${backendStdenv.cc}/bin/c++
  #  export TORCH_CUDA_ARCH_LIST="${lib.concatStringsSep ";" cudaCapabilities}"
  #  export FORCE_CUDA=1
  #'';

  
  propagatedBuildInputs = [
    setuptools
    torch
    ninja
    cmake
   ];

  nativeBuildInputs = [
    ninja
    which
    cmake
  ] ++ lib.optionals cudaSupport [
    cudaPackages.cuda_nvcc
  ];
   
  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
}
)
