{ lib
, python3Packages
, cudaPackages
, symlinkJoin
, pybind11
, setuptools
, ninja
, torch
, stdenv
, fetchFromGitHub
, fetchgit }: 

python3Packages.buildPythonPackage rec {
  pname = "diff-gaussian-rasterization";
  version = "0.0.0";
  #format = "setuptools";
  #format="pyproject";
  format = "wheel";
  src_repo = fetchgit {
    url = "https://github.com/graphdeco-inria/diff-gaussian-rasterization.git";
    rev = "59f5f77e3ddbac3ed9db93ec2cfe99ed6c5d121d"; # Specify the specific commit, tag, or branch
    sha256 = "sha256-zq6OxaSPOexgEV3uzlHguEDWmVV93nOD4FPcEkObpOE="; # SHA256 hash of the source
  };

  BUILD_CUDA_EXT = "1";
  CUDA_HOME = cudaPackages.cudatoolkit;
  CUDA_VERSION = cudaPackages.cudaVersion;

  #buildInputs = [
  #  pybind11
  #  cudaPackages.cudatoolkit
  #  ninja
  #];

  buildInputs = lib.optionals stdenv.isLinux (with cudaPackages; [
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
  ]);

  preBuild = ''
    echo "CUDA_HOME"
    echo $CUDA_HOME
  '';

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [
    setuptools 
    torch
    ninja
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
