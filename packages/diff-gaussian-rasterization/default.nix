{ lib
, buildPythonApplication
, buildPythonPackage
, toPythonModule
, python3Packages
, buildPackages
, fetchFromGitHub
, cmake
, glm
, ninja
, setuptools
, cudaPackages
, which
, torch
, fetchgit
}:

let
  inherit (torch) cudaCapabilities cudaPackages;
  inherit (cudaPackages) backendStdenv;
  stdenv = cudaPackages.backendStdenv;
in
buildPythonPackage rec {
  pname = "diff-gaussian-rasterization";
  version = "0.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ashawkey";
    repo = "diff-gaussian-rasterization";
    rev = "d986da0d4cf2dfeb43b9a379b6e9fa0a7f3f7eea";
    hash = "sha256-VosVYSjhXCXy3xCrwmumPgyY6baVk6wXAZXk+tP1LD0=";
  };

  env = {
    # Cf. https://github.com/NixOS/nixpkgs/blob/fccb6b42c3cad4e664236de94b0f9a0ea22b1d6e/pkgs/development/python-modules/torch/default.nix#L215
    TORCH_CUDA_ARCH_LIST = lib.concatStringsSep ";" cudaPackages.cudaFlags.cudaCapabilities;
  };

  build-system = [
    setuptools
  ];
  nativeBuildInputs = [
    cudaPackages.cuda_nvcc
    ninja
    which
    cmake
  ];

  dependencies = [
    torch
  ];
  buildInputs = lib.optionals stdenv.isLinux [
    glm
    (lib.getOutput "cxxdev" torch) # Propagates cuda dependencies
  ];

  # Don't cd into build/ before running pypaBuildPhase
  dontUseCmakeConfigure = true;

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
    broken = !torch.cudaSupport;
  };
}
