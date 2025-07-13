
{
  inputs = {
    systems.url = "github:nix-systems/default";
    ###
    # in your own flake, override this.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    ###

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "nix-systems";

    dns = {
      url = "github:kirelagin/dns.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    flake-guard-v2 = "github:the-computer-club/lynx/flake-guard-v2";
    flake-guard-v1 = "github:the-computer-club/lynx";
  };

  outputs = inputs@{self, nixpkgs, systems}:
    let
      zones =
        let
          NS = ["ns2.unallocatedspace.luni."];
          SOA = {
            nameServer = "unallocatedspace.luni.";
            adminEmail = "contact@unallocatedspace.luni";
            serial = 2025061100; # 2025-06-11-00
          };

          peers = self.wireguard.networks.asluni.peers.by-name;
          artixRec = (self.lib.peerARecord peers.artix);
        in
        {
          "unallocatedspace.luni" = artixRec // {
            inherit NS SOA;
            subdomains = {
              codex = artixRec;
              buildbot = artixRec;
              sesh = artixRec;
              tape = artixRec;
              turn = artixRec;
              media = artixRec;
              jitsi = artixRec;
              pgadmin = artixRec;
              admin = artixRec;
              mumble = artixRec;
            };
          };
        };
    in
    {
      wireguard.networks.asluni = {
        listenPort = 63723;
        peers.by-name = {
          cardinal = {
            publicKey = "2Q5yU5ueoDcEc+Segj/FJZ61IIiLWUVHtzf4uV31NjI=";
            ipv4 = [ "172.16.2.1/32" ];
            selfEndpoint = "unallocatedspace.dev:63723";
          };

          artix = {
            publicKey = "3CThsm++hbh48Oe7BX6PNQhUyWoCMsaq3gd0KvCoITM=";
            ipv4 = [ "172.16.2.2/32" ];
            selfEndpoint = "23.94.99.203:63723";
          };

          cypress = {
            publicKey = "nvuYPHJ2BUjXGyUMwr03XZYTMZGSQDyv3vDfZpGzfwo=";
            ipv4 = [ "172.16.2.3/32" ];
            persistentKeepalive = 10;
          };

          hydrogen = {
            publicKey = "qXsTs+IsmHeq9+rulmG6M7XhVgu/3N/wEgEaHPuHciU=";
            ipv4 = [ "172.16.2.4/32" ];
          };

          quantum = {
            publicKey = "FuOo9TwnE8P/zDBorjGNtsyPImHsHPxA21ePNrElsD0=";
            ipv4 = [ "172.16.2.5/32" ];
          };

          flagship = {
            publicKey = "qHQIOwGK7+6hXuBr6g1U00IzOM1p7Wc/ov/svPom0A8=";
            ipv4 = [ "172.16.2.6/32" ];
          };

          argon = {
            publicKey = "YO5w0tMvPt2lDdg9eD25wZsz9rWMTGbA/KuPYB6F1jQ=";
            ipv4 = [ "172.16.2.7/32" ];
          };

          pager1 = {
            publicKey = "NEN3VPGm58JLQkjUwq8MOhC/d7ZEZXcIjBl84ENGBzg=";
            ipv4 = [ "172.16.2.8/32" ];
          };

          simcra = {
            publicKey = "pq529jYwkJZZzdWB2fJ08A+41prV5gVsg3iE/kVN0GQ=";
            ipv4 = [ "172.16.2.9/32" ];
          };

          "0xc000000f" = {
            publicKey = "58qZ8KjLz80JPfSgsWU7iPpS6bjy94NONVoufLGxeX4=";
            ipv4 = [ "172.16.2.10/32" ];
          };

          tangobee = {
            publicKey = "5kGzZgx1QMLvdm7OsZoMzG7NC/4Pf3/S2MKFAvcR5wU=";
            ipv4 = [ "172.16.2.11/32" ];
          };

          voidhawk = {
            publicKey = "okKNJFTh42ZDFD5zcm2+bBJ6S2ht2QrQYb1Ktm+qdkY=";
            ipv4 = [ "172.16.2.12/32" ];
          };

          patch = {
            publicKey = "/tOmWpj1LZih8AqtS0P8PoBtI55+CY97TEUXx4iMxQo=";
            ipv4 = [ "172.16.2.13/32" ];
          };

          fluorine = {
            publicKey = "fCw+r4TKsxh36CdDSc6BTf0an9F2O8KQ189dYukpFHs=";
            ipv4 = [ "172.16.2.14/32" ];
            persistentKeepalive = 10;
          };

          "vxgw1.unallocatedspace.dev" = {
            publicKey = "YH/HBw/jOrG3EnXBu4asoCKGu7nnp1GvsjsFE/96q1E=";
            ipv4 = [ "172.16.2.15/32" "172.16.2.18/32" "172.16.2.19/32" ];
            persistentKeepalive = 10;
          };

          cypress-initrd = {
            publicKey = "rqHU9kjEuO6MBtXCON+qPjPwGBd1YF09oirl15M9xzM=";
            ipv4 = [ "172.16.2.16/32" ];
          };

          artix-initrd = {
            publicKey = "z74Ko8MZmZ40CKYfP3jekIydmtdNITRMQ55hrYp9TVQ=";
            ipv4 = [ "172.16.2.17/32" ];
          };

          lunarix-rpi = {
            publicKey = "tAow4qU5RDY0lxOmvBru/qB1cudT09pPFl+9zwkdF0Q=";
            ipv4 = [ "172.16.2.20/32" ];
            persistentKeepalive = 10;
          };

          porsche = {
            publicKey = "xqavFCvLVGYDyG/2ytgg7H5EV2wYXXEsvMWsOw2DyXM=";
            ipv4 = [ "172.16.2.21/32" ];
          };

          helium = {
            publicKey = "1OisEbl0ZTfqbUxrzMfKtoMD7Kz9VFahr0d+kpe9QB0=";
            ipv4 = [ "172.16.2.22/32" ];
          };

          hypothalamus = {
            publicKey = "9yzjykzsSnDxXA15sRf+PW/V3HFMxA3ZWTwngOWlUHk=";
            ipv4 = [ "172.16.2.23/32" ];
          };

          mesalon = {
            publicKey = "NBXhSrqgTN2LDfJ6MhqVwWFfxyBaqBjR5fYfLjb+gg8=";
            ipv4 = [ "172.16.2.24/32" ];
          };

          mesalon-vps = {
            publicKey = "/6egVjOjIIgxEzBAW+SWjSTmauxA5spi8cVAaQUX5GY=";
            ipv4 = [ "172.16.2.25/32" ];
          };

          ov13 = {
            publicKey = "S6yiCMatKlVX0WxyaWXTizasZPfQQ9oGM2pv82CtrgM=";
            ipv4 = [ "172.16.2.27/32" ];
          };

          sky = {
            publicKey = "EF4+fPzrAMqasS8Z7auajOuHmcvqcHVGQNPwhPo0/U8=";
            ipv4 = [ "172.16.2.42/32" ];
          };

          watermelon = {
            publicKey = "RksMNP9ojih2Jt8JqC1yWNImQnv0eJJ802fNS4T9pCI=";
            ipv4 = [ "172.16.2.55/32" ];
          };

          frogson = {
            publicKey = "5j44nM6qmbJ2S8B24aA/H6UEPVXJFfxf8sTacMktMis=";
            ipv4 = [ "172.16.2.69/32" ];
          };

          "jita.etherealryft.net" = {
            publicKey = "Ngp854R/d126OVrO7nRv0yj8rdHRjGURa5LbD/UT8Xk=";
            ipv4 = [ "172.16.2.71/32" ];
            selfEndpoint = "72.55.233.131:56854";
          };

          comet = {
            publicKey = "w90lfP16gY5debtjkfKVyKdL8mtlEXUmciNRTyTi7jw=";
            ipv4 = [ "172.16.2.96/32" ];
          };

          hexi = {
            publicKey = "UHmZ/pzB5cUFGEm9708pdG42vYVO+IkqtzeNaBAseWg=";
            ipv4 = ["172.16.2.99/32"];
          };

          Scott = {
            publicKey = "5W6KorrxAf3MWErAYlgSXcGUNEJfBwPTBlyEfRRfeXU=";
            ipv4 = [ "172.16.2.128/32" ];
          };

          merosity = {
            publicKey = "UHmZ/pzB5cUFGEm9708pdG42vYVO+IkqtzeNaBAseWg=";
            ipv4 = ["172.16.2.254/32"];
          };
        };
      };

      lib = rec {
        mapAttrsToList = f: attrs: map (name: f name attrs.${name}) (builtins.attrNames attrs);
        toNonFlakeParts = mapAttrsToList toPeers;
        toPeers = n: v: {
          publicKey = v.publicKey;
          allowedIPs = v.ipv4 ++ v.ipv6 or [];
          endpoint = v.selfEndpoint or null;
          persistentKeepalive = v.persistentKeepalive or null;
        };

        peerARecord = p: {
          A =
            if p ? ipv4
            then map (x: builtins.head (builtins.split "/" x)) p.ipv4
            else [];
          AAAA =
            if p ? ipv6
            then map (x: builtins.head (builtins.split "/" x)) p.ipv6
            else [];
        };
      };

      zones = builtins.mapAttrs (k: v: { data = inputs.dns.lib.toString k v; }) zones;

      packages = inputs.nixpkgs.lib.genAttrs (system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        {
          wgsd = pkgs.callPackage ./packages/wgsd.nix {};
          wgnamed = pkgs.callPackage ./packages/wgnamed.nix {};
          wireguard-tools = ./packages/wireguard-tools.nix {};
        }
      ) (import inputs.systems);

      flakeModules = {
        asluni = { inherit (self) wireguard; };
        flake-guard-v1 = inputs.flake-guard-v1.flakeModules.flake-guard;
        flake-guard-v2 = inputs.flake-guard-v2.flakeModules.flake-guard;
      };

      nixosModules = {
        flake-guard = inputs.lynx.nixosModules.flake-guard;

        ##
        # Server DNS entries.
        # This include service-discovery.
        server-dns = (import ./nixosModules/server/dns.nix self);

        ####
        # Peering information
        asluni = { inherit (self) wireguard; };

        ####
        # Names for peers.
        client-named-peers = ./nixosModules/client/wg-named.nix;

        ####
        #
        client-wgsd-discovery = ./nixosModules/client/wgsd-timer.nix;

        ####
        # Client configuration using dnscrypt over doh. (dns over http)
        # Currently the dns service
        client-dns-dnscrypt = ./nixosModules/client/resolver/dnscrypt2-proxy.nix;
        client-dns-resolvconf = ./nixosModules/client/resolver/resolvconf.nix;
        client-dns-resolved = ./nixosModules/client/resolver/resolvconf.nix;
        client-dns-wgquick = ./nixosModules/client/resolver/wg-quick.nix;

        client-hostnames = {lib, ...}: {
          autoConfig."networking.hostnames".names.enable = lib.mkDefault true;
        };

        ####
        # determine how the network is configured on box.
        client-flake-guard-legacy.networking.wireguard.interfaces.asluni.peers =
          self.lib.nonFlakeParts self.wireguard.networks.asluni;

        client-flake-guard-v1 = {lib, ...}: {
          # This version preferred you using
          # self.nixosModules.flake-guard-host
          # which was generated from using flake-parts.
          networking.wireguard.networks.asluni = lib.mkDefault self.wireguard.networks.asluni;
          networking.wireguard.enable = true;
        };

        client-flake-guard-v2.wireguard.networks.asluni = {lib, ...}: {
          # This version ports the existing flake-parts options to
          # nixos modules. This also features different output types.
          # NOTE: will be superseeded by v3 eventually, expect
          # breaking changes between v2 & v3.
          imports = [ inputs.flake-guard-v2.nixosModules.flake-guard ];
          autoConfig = {
            openFirewall = lib.mkDefault true;
            "networking.wireguard" = {
              interface.enable = lib.mkDefault true;
              peers.mesh.enable = lib.mkDefault true;
            };
          };
        };

        client-certs.security.pki.certificateFiles = [ ./pki/root_ca.cert ];

        ####
        # Implements base server,
        # which is also a client.
        luninet-server = {config, lib, pkgs, ...}: {
          imports = with self.nixosModule; [
            client
            server-dns
          ];

          services.dns-forwarder.enable = lib.mkDefault true;
          services.nsd.enable = lib.mkDefault true;
          services.coredns.enable = lib.mkDefault true;

          networking.firewall.interfaces.asluni.allowedUDPPorts =
            (lib.optional config.dns-forwarder.enable config.dns-forwarder.listenPort)
            ++ (lib.optional config.coredns.enable 53);
        };

        #####
        # full compatiablity with luninet is the following attributes:
        # - wgsd: p2p capabilities via dns.
        # - pki: added to cert chain for https.
        # - wgnamed: prefixes `wg show` with
        #            the hostname per peer.
        client = {config, lib, pkgs, ...}: {
          imports = with self.nixosModules; [
            asluni
            client-certs
            client-wgsd-discovery
            client-named-peers
            flake-guard-v2
            client-flake-guard-v2
          ];

          wireguard.enable = lib.mkDefault true;
          wireguard.named.enable = lib.mkDefault true;
        };
      };

      pki = {
        root = ./pki/root_ca.crt;
        unallocatedspace_ca = ./pki/unallocatedspace_ca.crt;
        unallocatedspace = ./pki/unallocatedspace.crt;
      };
    };
}
