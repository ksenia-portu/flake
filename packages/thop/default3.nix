{ lib, pkgs, pythonPackages, executing, setuptools-scm }:

pythonPackages.buildPythonPackage rec {
    pname = "thop";
    version = "0.1.1.post2209072238";
    name = "${pname}-${version}";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "06f8fa6e7db0a9897ada5e096eab95f9c2e3811e69e7a29f747517e4377f3d2b";
    };

    propagatedBuildInputs = with pythonPackages; [
      setuptools-scm
      executing
    ];

    doCheck = false;

}
