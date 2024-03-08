{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    union.url = "git+file:../union";
    ethereum-nix = {
      url = "github:kaiserkarel/ethereum.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, union, ethereum-nix }:
    let
      keys = [
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAY6rYPYLUl8ccZsZUUZgTyqpwp0CUIYsBhy+4Ub/UuB'' # kaiserkarel
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnFdSHtSGiwHlDEESfJseOArZ8HNCVlIcreGc2VS7b2'' # omar aziz
      ];
    in
    {
      nixosConfigurations = {
        testnet = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/testnet/configuration.nix
            union.nixosModules.unionvisor
            {
              _module.args = { inherit keys; };

              networking.firewall.allowedTCPPorts = [ 80 443 26656 26657 26666 ];
              services.unionvisor = {
                enable = true;
                moniker = "hubble";
                app-toml = machines/testnet/app.toml;
                client-toml = machines/testnet/client.toml;
                config-toml = machines/testnet/config.toml;
              };
            }
          ];
        };
        miasma = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [
              ethereum-nix.overlays.default
            ];
          };

          modules = [
            ./machines/miasma/configuration.nix
            ethereum-nix.nixosModules.default
            ./modules/ethereum.nix
            {
              _module.args = { inherit keys; };
            }
          ];
        };
        sepolia = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [
              ethereum-nix.overlays.default
            ];
          };

          modules = [
            ./machines/sepolia/configuration.nix
            ethereum-nix.nixosModules.default
            ./modules/sepolia.nix
            ./modules/hubble.nix
            {
              _module.args = { inherit keys; };
            }
          ];
        };
        db = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            union.nixosModules.hubble
            ./machines/db/configuration.nix
            ./modules/timescale.nix
            ./modules/pgbouncer.nix
            ./modules/hubble.nix
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
