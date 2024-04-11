{
  nixConfig = {
    extra-substituters = [ "https://ai.cachix.org" ];
    extra-trusted-public-keys = [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];
  };

  description = "A Nix Flake that makes AI reproducible and easy to run";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    invokeai-src = {
      url = "github:invoke-ai/InvokeAI/v4.0.4";
      flake = false;
    };
    llama = {
      url = "github:ksenia-portu/llama-cpp-python-flake";
      flake = true;
    };
    ultra = {
      url = "github:Alan01252/ultralytics-nix-flake";
      flake = true;
    };    
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
  outputs = { self, flake-parts, invokeai-src, hercules-ci-effects, llama, ultra, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem = { config, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs { 
          config.allowUnfree = true; 
          inherit system;
        };
        packages = {        
          llama-cpp        = inputs.llama.packages.${system}.llama-cpp; 
          llama-cpp-python = inputs.llama.packages.${system}.llama-cpp-python; 
          #ultralytics      = inputs.ultra.packages.${system}.ultralytics;
        };
        overlayAttrs = config.packages;
      };
      systems = [  "x86_64-linux"];
      debug = true;
      imports = [
        hercules-ci-effects.flakeModule
#        ./modules/nixpkgs-config
        ./overlays
        ./projects/invokeai
        ./projects/textgen
        ./website
        inputs.flake-parts.flakeModules.easyOverlay #for llama
      ];
    };
}
