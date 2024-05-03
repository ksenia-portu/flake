{ inputs, ... }:
{
  perSystem = { lib, system, pkgsCuda, ... }: {
    _module.args.pkgsCuda = import inputs.nixpkgs {
      inherit system;

      config.cudaSupport = true;
      # config.cudaCapabilities = [ "7.0" "8.0" "8.6" ];
      # config.cudaEnableForwardCompat = false;

      config.allowUnfreePredicate =
        let
          isAllowed = lib.flip builtins.elem [
            "CUDA EULA"
            "cuDNN EULA"
          ];
        in
        p: builtins.all
          (license: isAllowed license.shortName)
          (p.meta.licenses or [ p.meta.license ]);
    };
    legacyPackages = {
      # FIXME: rename default.nix's into package.nix's
      # to reduce the current .#tree.<name>.default to .#tree.<name>
      tree = lib.packagesFromDirectoryRecursive
        {
          inherit (pkgsCuda.python3Packages) callPackage;
          directory = ../packages;
        };
    };
  };
}
