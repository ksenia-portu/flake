{ buildPythonPackage, fetchPypi, lib
, fetchFromGitHub
, diffusers
, pydantic_1
}:
let
  diffusers_old = diffusers.overrideAttrs (old: {
    src = fetchFromGitHub {
      owner = "huggingface";
      repo = "diffusers";
      rev = "refs/tags/v0.18.1";
      hash = "sha256-9r/1vW7Rhv9+Swxdzu5PTnlQlT8ofJeZamHf5X4ql8w=";
    };
  });

in buildPythonPackage rec {
  pname = "deforum";
  version = "0.1.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-vLwkSVj9gD6oDOeybQ4tTwcwey4mWuXYCjw9qFoaFsA=";
  };

  propagatedBuildInputs =
    [ pydantic_1 ];
  
  passthru.optional-dependencies = { 
    diffusers = [
      diffusers_old
    ];
  };    
  # TODO FIXME
  doCheck = false;

  #meta = with lib; {
  #  description = "";
  #  homepage = "https://richzhang.github.io/PerceptualSimilarity/";
  #};
}
