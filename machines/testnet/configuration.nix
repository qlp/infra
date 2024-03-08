{ keys, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "ubuntu-4gb-nbg1-1";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = keys;
  system.stateVersion = "23.11";
}
