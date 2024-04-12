{ config, lib, pkgs, keys, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "union-node-1";
  networking.domain = "";
  users.users.root.openssh.authorizedKeys.keys = keys;
  services.openssh.enable = true;
}
