{ config, lib, pkgs, ... }:
{
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [ "mullvad-base-doh" ];

      bootstrap_resolvers = [
        "1.1.1.1:53"
        "8.8.8.8:53"
        ""
      ];

      listen_addresses = [
        "127.0.0.1:53"
        "[::1]:53"
      ];

      anonymized_dns = {
        routes = [
          {
            server_name = "*";
            via = [
              "anon-cs-montreal"
              "anon-cs-nyc1"
              "anon-cs-nyc2"
            ];
          }
        ];

        skip_incompatible = true;
      };

      sources = {
        public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            "https://ipv6.download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];

          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        relays = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
            "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
            "https://ipv6.download.dnscrypt.info/resolvers-list/v3/relays.md"
          ];

          cache_file = "/var/cache/dnscrypt-proxy/relays.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };

      forwarding_rules = pkgs.writeText "forwarding-rules.txt" ''
        luni 172.16.2.2:5334
        luni.b32 172.16.2.2:5333
      '';
    };
  };

  # Use dnscrypt-proxy as nameserver instead of dhcpcd or systemd-resolved
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    dhcpcd.extraConfig = "nohook resolv.conf";
  };

  services.resolved.enable = false;
  networking.networkmanager.dns = "none";
}
