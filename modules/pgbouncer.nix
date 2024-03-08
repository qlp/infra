{ config, pkgs, ... }:
{
  services.pgbouncer = {
    enable = true;
    listenAddress = "0.0.0.0";
    listenPort = 6432;
    databases = {
      union = "host=/run/postgresql/ port=5432 auth_user=pgbouncer dbname=union";
    };
    authFile = "/secrets/pgbouncer_authfile";
    authType = "scram-sha-256";
    authUser = "pgbouncer";
    authQuery = "SELECT usename, passwd FROM pg_shadow WHERE usename=$1";
  };
  networking.firewall.allowedTCPPorts = [ 6432 5432 ];
}
