
{ ... }:
{
  sops = {
    defaultSopsFile = ../secrets/testnet-9/secrets.json;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    gnupg.sshKeyPaths = [ ]; # https://github.com/Mic92/sops-nix/issues/65#issuecomment-929082304
    secrets = {
      "unionvisor/priv_validator_key.json" = {
        restartUnits = [ "unionvisor.service" ];
        format = "binary";
        sopsFile = ../../secrets/testnet-9/priv_validator_key.json;
      };
      "unionvisor/node_key.json" = {
        restartUnits = [ "unionvisor.service" ];
        format = "binary";
        sopsFile = ../../secrets/testnet-9/node_key.json;
      };
    };
  };
}
