{
  description = "A highly structured configuration database.";

  epoch = 201909;

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.home.url = "github:rycee/home-manager/bqv-flakes";

  outputs = inputs@{ self, home, nixpkgs }:
    let
      inherit (builtins) listToAttrs baseNameOf attrNames readDir;
      inherit (nixpkgs.lib) removeSuffix;
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = self.overlays;
        config = { allowUnfree = true; };
      };
    in {
      nixosConfigurations =
        let
          configs = import ./hosts (inputs // { inherit system pkgs; });
        in configs;

      overlay = import ./pkgs;

      overlays = let
        overlays = map (name: import (./overlays + "/${name}"))
          (attrNames (readDir ./overlays));
      in overlays;

      packages.x86_64-linux = {
        inherit (pkgs) pragmata_pro;
      };

      nixosModules = let
        prep = map (
          path: {
            name = removeSuffix ".nix" (baseNameOf path);
            value = import path;
          }
        );

        # modules
        moduleList = import ./modules/list.nix;
        modulesAttrs = listToAttrs (prep moduleList);

        # profiles
        profilesList = import ./profiles/list.nix;
        profilesAttrs = { profiles = listToAttrs (prep profilesList); };
      in modulesAttrs // profilesAttrs;
    };
}
