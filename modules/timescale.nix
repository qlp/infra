{ config, pkgs, lib, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    extraPlugins = with pkgs.postgresql15Packages; [
      timescaledb
    ];
    dataDir = "/volumes/union/postgresql/15";
    settings = {
      shared_preload_libraries = "timescaledb";
      max_connections = 89;
      shared_buffers = "50688MB";
      effective_cache_size = "152064MB";
      maintenance_work_mem = "2GB";
      checkpoint_completion_target = 0.9;
      wal_buffers = "16MB";
      default_statistics_target = 100;
      random_page_cost = 1.1;
      effective_io_concurrency = 200;
      work_mem = "145799kB";
      huge_pages = "try";
      min_wal_size = "1GB";
      max_wal_size = "4GB";
      max_worker_processes = 64;
      max_parallel_workers_per_gather = 4;
      max_parallel_workers = 64;
      max_parallel_maintenance_workers = 4;
    };
    enableTCPIP = true;
    ensureDatabases = [
      "union"
    ];
    ensureUsers = [
      {
        name = "pgbouncer";
        ensureClauses = {
          superuser = true;
          login = true;
        };
      }
      {
        name = "union";
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
        };
      }
    ];
    authentication = lib.mkForce ''
      local   all             all                                     peer
      host    all             all             0.0.0.0/0            scram-sha-256
      host    all             all             ::1/128                 scram-sha-256
    '';
  };
}

