{ lib
, buildPythonPackage
, fetchFromGitHub
, cmake
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
, stdenv
, fetchgit
}:

buildPythonPackage rec {
  pname = "diff-gaussian-rasterization";
  version = "0.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "graphdeco-inria";
    repo = "diff-gaussian-rasterization";
    rev = "59f5f77e3ddbac3ed9db93ec2cfe99ed6c5d121d";
    hash = "sha256-SKSSpEa9ydi4+aLPO4cD/N/nYnM9Gd5Wz4nNNvBKb58=";
  };

  #BUILD_CUDA_EXT = "1";
  #TORCH_CUDA_ARCH_LIST="6.1+PTX";
  CUDA_HOME = cudaPackages.cudatoolkit;
  CUDA_VERSION = cudaPackages.cudaVersion;
  cxx = if stdenv.isLinux then gcc12 else clang;
  #CUDAHOSTCXX=cudaPackages.cudatoolkit.cc/bin/c++;
  #CUDAHOSTCXX = lib.optionalString cudaSupport "${stdenv.cc}/bin/cc";

  nativeBuildInputs = lib.optionals stdenv.isLinux (with cudaPackages; [
    setuptools
    cuda_nvtx
    cmake
    cxx
    gcc12
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
    which
    ninja
  ]);
  buildInputs = [git cacert];
  preBuild = ''
    echo "CUDA_HOME"
    echo $CUDA_HOME
  '';

  propagatedBuildInputs = [
    torch
    ninja
    cmake
  ];
  cmakeFlags = [
    "-DCMAKE_CXX_COMPILER=${clang}/bin/clang++"
  ];
  # //export CMAKE_CXX_COMPILER=${clang}/bin/clang++
  #//export CUDAHOSTCXX=${cudaPackages.cudatoolkit.cc}/bin/c++
  configurePhase = ''
      mkdir build && cd build
      cmake ..  "-GNinja" "-DDCMAKE_INSTALL_PREFIX=./diff-gaussian-rasterization"  "-DCMAKE_BUILD_TYPE=RelWithDebInfo"
    '';
  
  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
  shellHook = ''
    export CMAKE_C_COMPILER=gcc12
    export CUDAHOSTCXX=${cudaPackages.cudatoolkit.cc}/bin/c++ 
  '';  
}

