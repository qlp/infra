{ config, pkgs, union, ... }:
{
  services.hubble = {
    enable = true;
    api-key-file = "/etc/hubble/hubble.key";
    datastore-method = "timescale";
    indexers = [
      { url = "http://167.235.25.11:26657"; type = "tendermint"; }
      # { url = "http://159.69.146.56:8545"; type = "ethereum"; start = 0; }
      # { url = "https://rpc.ankr.com/eth/864e6497c4508f901b2dbaec5ae848868e2163370ec1776d3262960137dc38eb"; type = "ethereum"; start = 0; }
    ];
    metrics-addr = "0.0.0.0:9095";
    log-level = "hubble=info";
  };
}
