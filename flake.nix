{
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
  # WARNING:  NVF only works with linux and darwin systems.
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
