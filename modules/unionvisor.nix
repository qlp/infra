{ config, ... }:
{
  services.unionvisor = {
    enable = true;
    logFormat = "json";
    network = "union-testnet-9";
    moniker = "q8p";
    home = "/volumes/union/unionvisor";
    node-key-json = config.sops.secrets."unionvisor/node_key.json".path;
    priv-validator-key-json = config.sops.secrets."unionvisor/priv_validator_key.json".path;
    app-toml = ../uniond-config/union-testnet-9-q8p/app.toml;
    client-toml = ../uniond-config/union-testnet-9-q8p/client.toml;
    config-toml = ../uniond-config/union-testnet-9-q8p/config.toml;
  };
}
