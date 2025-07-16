self: { config, lib, pkgs, ... }:
let
  zones = self.asluni.zones;
  wgsd = self.packages.${pkgs.system}."coredns/wgsd";
in
{
  services.coredns = {
    enable = lib.mkDefault true;
    extraArgs = lib.mkDefault [ "-dns.port=53" ];
    zones = lib.mkDefault zones;
    config = lib.mkDefault ''
      .:53 .:5334 {
          bind asluni
          wgsd luni.b32. asluni
          log
          errors

          # Health check endpoint
          health :8220

          # Prometheus metrics
          # prometheus :9153

          auto luni {
              directory ${config.services.coredns.zoneDir}
              reload 30s
          }

          acl {
              allow net 172.16.2.1/32
              block net 127.0.0.0/8
              block net 0.0.0.0/0
          }

          # secondary {
          #     transfer to 172.16.2.1
          #     transfer from 172.16.2.2
          # }

          # Forward unresolved queries
          forward . 8.8.8.8 8.8.4.4 {
              except example.org luni.b32
              health_check 5s
          }

          # Cache responses
          cache 30
      }

      # Admin/metrics interface
      . :8220 {
          bind 127.0.0.1
          health
          ready
      }
    '';
    package = lib.mkDefault wgsd;
  };

  # Security hardening for systemd service
  systemd.services.coredns = {
    serviceConfig = {
      # Required capabilities for WireGuard and DNS
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE CAP_NET_ADMIN";
      AmbientCapabilities = "CAP_NET_BIND_SERVICE CAP_NET_ADMIN";

      # Additional security hardening
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectControlGroups = true;
      RestrictSUIDSGID = true;
      RestrictRealtime = true;
      RestrictNamespaces = true;
      LockPersonality = true;
      MemoryDenyWriteExecute = true;

      # Network restrictions
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_NETLINK" ];

      # Allow access to WireGuard interfaces and zone files
      ReadWritePaths = [ config.services.coredns.zoneDir ];
    };
  };

  # Firewall rules
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };

  # Optional: Monitoring setup
  services.prometheus.exporters.coredns = lib.mkIf config.services.prometheus.enable {
    enable = lib.mkDefault true;
    port = 9153;
  };
}
