{ keys, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];
  
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "8192";
  }];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "testnet-9";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = keys;
  system.stateVersion = "24.04";
}