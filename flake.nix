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
        union-node-1 = 
          let
            system = "aarch64-linux";
            pkgs = import nixpkgs { inherit system; };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./machines/union-node-1/configuration.nix
              ./modules/docker.nix
              union.nixosModules.unionvisor
              {
                system.stateVersion = "23.11";
                # Base configuration for openstack-based VPSs
                imports = [ "${nixpkgs}/nixos/modules/virtualisation/openstack-config.nix" ];

                # Allow other validators to reach you
                networking.firewall.allowedTCPPorts = [ 80 443 26656 26657 ];

                # Unionvisor module configuration
                services.unionvisor = {
                  enable = true;
                  moniker = "qlp-1";
                };

                # OPTIONAL: Some useful inspection tools for when you SSH into your validator
                environment.systemPackages = with pkgs; [
                  bat
                  bottom
                  helix
                  jq
                  neofetch
                  tree
                ];
              }
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
