{ config, lib, pkgs, keys, ... }:

{
  # imports =
  #   [
  #     ./hardware-configuration.nix
  #   ];

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "union-node-1";
  networking.domain = "";
  users.users.root.openssh.authorizedKeys.keys = keys;
  # users.users.union = {
  #   isSystemUser = true;
  #   group = "union";
  #   description = "Union daemon user";
  #   extraGroups = [ "docker" ];
  # };
  # users.groups.union = {};
  services.openssh.enable = true;
  # system.stateVersion = "23.11";
}
