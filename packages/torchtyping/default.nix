{ lib, pkgs, pythonPackages, executing, setuptools-scm }:

pythonPackages.buildPythonPackage rec {
    pname = "torchtyping";
    version = "0.1.4";
    name = "${pname}-${version}";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-R2M3XRd1JkG9G/8Pqt2t4pvjwSX8pjVePO53AOl1/bU=";
    };

    
    propagatedBuildInputs = with pythonPackages; [
      setuptools-scm
      executing
    ];

    doCheck = false;

    meta = with lib; {
      homepage = https://github.com/pwwang/python-varname;
      description = "Dark magics about variable names in python.";
    };
}
