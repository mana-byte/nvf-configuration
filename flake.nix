{
  description = "A Neovim configuration using NVF by notashelf and customized by mana-byte";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default =
          (nvf.lib.neovimConfiguration {
            pkgs = pkgs;
            modules = [./nvf-configuration.nix];
          }).neovim;
      }
    );
}
