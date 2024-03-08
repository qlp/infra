{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };
  outputs = { self, nixpkgs }:
    let
      keys = [
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4rUA+CKIC1RK6NVxMaPkYIABhs5zL2Hwdxu4HSrpOH jurriaan@pruijs.nl'' # jurriaan
      ];
    in
    {
      nixosConfigurations = {
        union-node-1 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./machines/union-node-1/configuration.nix
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
