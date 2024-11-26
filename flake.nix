{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    union.url = "github:/unionlabs/union/create-bunlde-testnet-9";
    sops-nix.url = "github:Mic92/sops-nix";
  };
  outputs = { self, nixpkgs, sops-nix, ... }:
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
              sops-nix.nixosModules.sops

              ./machines/testnet-9/configuration.nix
              ./machines/testnet-9/datadog.nix
              ./machines/testnet-9/sops.nix
              {
                _module.args = { 
                  inherit keys; 
                   
                   checks = {
                      # Datadog does not handle Hetzner: https://github.com/DataDog/datadog-agent/issues/20369
                      # Hence we need this workaround.
                      ntp = {
                        init_config = { };
                        instances = [
                          {
                            hosts = [
                              "0.datadog.pool.ntp.org"
                              "1.datadog.pool.ntp.org"
                              "2.datadog.pool.ntp.org"
                              "3.datadog.pool.ntp.org"
                            ];
                          }
                        ];
                      };
                      process = {
                        instances = [
                          { name = "uniond"; search_string = [ "uniond" ]; }
                        ];
                      };
                      journald = {
                        logs = [
                          {
                            type = "journald";
                            container_mode = true;
                          }
                        ];
                      };
                    };
                  };

              }
            ];
          };
      };
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixpkgs-fmt;
    };
}
