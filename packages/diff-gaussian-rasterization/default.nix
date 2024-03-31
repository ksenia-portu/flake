{ lib
, buildPythonPackage
, buildPackages
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
  #pyproject = true;
  #format = "pyproject";

  src = fetchFromGitHub {
    owner = "graphdeco-inria";
    repo = "diff-gaussian-rasterization";
    rev = "59f5f77e3ddbac3ed9db93ec2cfe99ed6c5d121d";
    hash = "sha256-SKSSpEa9ydi4+aLPO4cD/N/nYnM9Gd5Wz4nNNvBKb58=";
  };

  
  depsBuildBuild = [ buildPackages.stdenv.cc ];
  nativeBuildInputs = lib.optionals stdenv.isLinux (with cudaPackages; [
    setuptools
    cuda_nvtx
    cmake
    #cxx
    stdenv.cc
    #gcc12
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

  propagatedBuildInputs = [
    setuptools
    torch
  ];
  
  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
}

