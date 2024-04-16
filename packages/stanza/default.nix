{ lib
, buildPythonPackage
, setuptools 
, emoji
, numpy
, protobuf
, requests
, networkx
, toml
, torch
, tqdm
, packaging
, fetchFromGitHub, fetchgit }: 

buildPythonPackage rec {
  pname = "stanza";
  version = "1.8.1";
  format="pyproject";
  src_repo = fetchgit {
    url = "https://github.com/stanfordnlp/stanza.git";
    rev = "c2d72bd14cf8cc28bd4e41a620692bbce5f43835"; # Specify the specific commit, tag, or branch
    sha256 = "sha256-MO9trPkemVDzlVrO6v6N27RY2SNwflj+XlUrB1NqFGc="; # SHA256 hash of the source
  };

  # Extract the specific subdirectory within the repository
  propagatedBuildInputs = [  
    setuptools
    emoji
 numpy
 protobuf
 requests
 networkx
 toml
 torch
 tqdm   
 packaging
  ];
  src = src_repo;  # Adjust the path to your desired subdirectory

  patches = [ ./attr_remove.patch ];

  meta = with lib; {
    description = "Description of your package";
    license = licenses.mit;
  };
} 
 
