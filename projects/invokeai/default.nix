{ config, inputs, lib, withSystem, ... }:

let
  l = lib // config.flake.lib;
  inherit (config.flake) overlays;
in

{
  perSystem = { config, pkgs, ... }: let
    commonOverlays = [
      overlays.python-fixPackages
      (l.overlays.callManyPackages [
        ../../packages/hub-sdk
        ../../packages/torchtyping
        ../../packages/diff-gaussian-rasterization
        ../../packages/mamba-ssm
        ../../packages/autogen
        ../../packages/flaml
        ../../packages/stanza
        #../../packages/cpuinfo
        #../../packages/typing
        ../../packages/colour-science
        ../../packages/deforum
        ../../packages/zhipuai
        ../../packages/simple-lama-inpainting
        ../../packages/clip-interrogator
        #../../packages/diffusers_old
        ../../packages/gaussian-splatting
        #../../packages/typeguard
        ../../packages/token-count
        ../../packages/causal-conv1d
        #../../packages/opencv-python-headless
        ../../packages/rembg
        ../../packages/evalidate
        ../../packages/color-matcher
        ../../packages/varname
        ../../packages/pymeshlab
        ../../packages/thop
        ../../packages/objprint
        ../../packages/kiui
        ../../packages/zhipuai
        ../../packages/timm
        ../../packages/ultralytics
        ../../packages/plyfile
        ../../packages/segment_anything
        ../../packages/lpips
        ../../packages/mediapipe
        #../../packages/safetensors
        ../../packages/easing-functions
        ../../packages/dynamicprompts
        ../../packages/controlnet-aux
        #../../packages/fastapi
        #../../packages/fastapi-events
        #../../packages/fastapi-socketio
        #../../packages/starlette
        ../../packages/pytorch-lightning
        ../../packages/compel
        ../../packages/taming-transformers-rom1504
        ../../packages/albumentations
        ../../packages/qudida
        ../../packages/gfpgan
        ../../packages/basicsr
        ../../packages/facexlib
        ../../packages/realesrgan
        ../../packages/codeformer
        ../../packages/clipseg
        #../../packages/kornia
        ../../packages/picklescan
        ../../packages/pypatchmatch
        ../../packages/torch-fidelity
        ../../packages/resize-right
        ../../packages/torchdiffeq
        ../../packages/accelerate
        ../../packages/clip-anytorch
        ../../packages/clean-fid
        ../../packages/getpass-asterisk
        ../../packages/mediapipe
        ../../packages/python-engineio
      ])
      (final: prev: lib.mapAttrs
        (_: pkg: pkg.overrideAttrs (old: {
          nativeBuildInputs = old.nativeBuildInputs ++ [ final.pythonRelaxDepsHook ];
          pythonRemoveDeps = [ "opencv-python-headless" "opencv-python" "tb-nightly" "clip" ];
        }))
        {
          inherit (prev)
            albumentations
            qudida
            gfpgan
            basicsr
            facexlib
            realesrgan
            clipseg
          ;
        }
      )
    ];

    python3Variants = {
      amd = 
        l.overlays.applyOverlays 
        pkgs.python3Packages 
        ( commonOverlays ++ [
          overlays.python-torchRocm
        ]
        );
      nvidia = 
        l.overlays.applyOverlays 
        pkgs.python3Packages 
        (commonOverlays ++ [
        overlays.python-torchCuda
      ]);
    };

    src = inputs.invokeai-src;

    mkInvokeAIVariant = args: pkgs.callPackage ./package.nix ({ inherit src inputs ; } // args);
  in {
    packages = {
      invokeai-amd = mkInvokeAIVariant {
        python3Packages = python3Variants.amd;
      };
      invokeai-nvidia = mkInvokeAIVariant {
        python3Packages = python3Variants.nvidia;
      };
    };
  };

  flake.nixosModules = let
    packageModule = pkgAttrName: { pkgs, ... }: {
      services.invokeai.package = withSystem pkgs.system (
        { config, ... }: lib.mkOptionDefault config.packages.${pkgAttrName}
      );
    };
  in {
    invokeai = ./nixos;
    invokeai-amd = {
      imports = [
        config.flake.nixosModules.invokeai
        (packageModule "invokeai-amd")
      ];
    };
    invokeai-nvidia = {
      imports = [
        config.flake.nixosModules.invokeai
        (packageModule "invokeai-nvidia")
      ];
    };
  };
}
