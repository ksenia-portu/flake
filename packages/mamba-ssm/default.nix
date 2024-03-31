{ lib, python3Packages, fetchFromGitHub, fetchgit
,setuptools
, torch
, gcc
, cudaPackages
, stdenv
}: 

python3Packages.buildPythonPackage rec {
  pname = "mamba-ssm";
  version = "v1.2.0";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/state-spaces/mamba.git";
    rev = "2845255a95f7e4a76fe649ec0532178fe3015dd0";  # Specify the specific commit, tag, or branch
    sha256 = "sha256-7NHUjb5hmp197mvQGqGu0RxCFFABHakwj8F57A9ETEY="; # SHA256 hash of the source
  };

  nativeBuildInputs = lib.optionals stdenv.isLinux (with cudaPackages; [
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
    gcc
  ]);
  
  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [ 
    cudaPackages.cuda_nvcc 
    setuptools
    torch
    gcc
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
