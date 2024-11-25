{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    union.url = "git+ssh://git@github.com/unionlabs/union";
  };
  outputs = { self, nixpkgs, union, ... }:
    let
      keys = [
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4rUA+CKIC1RK6NVxMaPkYIABhs5zL2Hwdxu4HSrpOH jurriaan@pruijs.nl'' # jurriaan
      ];
    in
    {
      nixosConfigurations = {
        testnet-9 = 
          let
            system = "aarch64-linux";
            pkgs = import nixpkgs { inherit system; };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./machines/testnet-9/configuration.nix
              {
                _module.args = { inherit keys; };
              }
            ];
          };
      };
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixpkgs-fmt;
    };
}
