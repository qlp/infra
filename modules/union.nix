{ nixpkgs, union, ... }
{
  union.nixosModules.unionvisor
  {
    # Base configuration for openstack-based VPSs
    imports = [ "${nixpkgs}/nixos/modules/virtualisation/openstack-config.nix" ];

    # Allow other validators to reach you
    networking.firewall.allowedTCPPorts = [ 80 443 26656 26657 ];

    # Unionvisor module configuration
    services.unionvisor = {
      enable = true;
      moniker = "qlp-001";
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
