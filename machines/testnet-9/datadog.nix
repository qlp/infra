{ pkgs, checks, ... }:
{
  users.users.datadog.extraGroups = [ "systemd-journal" ];
  services.datadog-agent = {
    inherit checks;
    # package = pkgs.datadog-agent.override { buildGoModule = pkgs.buildGo121Module; };
    enable = true;
    apiKeyFile = "/run/secrets/datadog/datadog_api.key";
    enableLiveProcessCollection = true;
    enableTraceAgent = true;
    site = "datadoghq.eu";
    extraConfig = { logs_enabled = true; };
    logLevel = "INFO";
    extraIntegrations = {
      http_check = pythonPackages: [ pythonPackages.hatchling ];
      journald = pythonPackages: [ pythonPackages.hatchling ];
      openmetrics = _: [ ];
    };
  };
}
