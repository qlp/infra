{ keys, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  system.stateVersion = "23.11";
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "db";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = keys;
}
