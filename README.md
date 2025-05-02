# automous-zones
A P2P wireguard mesh network that underpins computer-club infrastructure. Its used as tunneling layer that lets us play games, share files, host services, etc.

## FAQ

What do you have access to:
  - whatever peers have known endpoints is what you can reach at any given time.
  - some peers have `selfEndpoint` which lets you connect to them anytime.
  - All the IP addresses under 172.16.2.1 - 172.16.2.254 are routed under the VPN, which is everything you potentially have access to.
  

Can people connect to me without me knowing:
  - No one can connect to you.
  
    Except, on the occasion that you try connecting to a peer with `selfEndpoint` defined, or yourself have defined `selfEndpoint`. Then can connect back to you while a pathway is established.
  
    If this is of concern to you, 
    make sure to include firewall rules at the endpoint which is hosting the private key to drop incoming connections. (This is the default policy on most OS's)
  
Can I turn off wireguard?:
  - You absolutely do not need this VPN running all the time.

Does is mask my traffic like NordVPN?:
  - No, we do not forward public WAN traffic. The setup is a split VPN

What is a split VPN?:
  - A split VPN is a configuration where sometimes traffic is encapsulated. 
  In the case of this network, only 172.16.2.0/24 is encapsulated, so only packets
  addressed to them will be sent through the VPN.
  

## Support options
----

### wg-quick

wg-quick configuration [wg-asluni.conf](https://github.com/the-computer-club/automous-zones/releases/download/latest/wg-asluni.conf)

#### To automatically update
```
#!/usr/bin/env sh

curl https://github.com/the-computer-club/automous-zones/releases/download/latest/wg-asluni.conf > /tmp/latest-asluni.conf

cat /var/secrets/asluni.tmpl /tmp/latest-asluni.conf > /var/lib/wireguard/asluni.conf

rm /tmp/latest-asluni.conf
```


#### build from source
```
nix eval github:the-computer-club/automous-zones#nixosModules.asluni.wireguard.networks.asluni.peers.by-name --apply "x: {Peer = builtins.attrValues ((builtins.mapAttrs(name: peer: { AllowedIPs = peer.ipv4; PublicKey = peer.publicKey; } // (if peer ? selfEndpoint then { Endpoint = peer.selfEndpoint; } else {}) )) x);}" --json | remarshal --if json --of toml | sed 's/"//g' | sed 's/\[\[/\[/g' | sed 's/\]\]/\]/g' | sed "s/\[1/1/" | sed "s/2\]/2/g"
```


## Nixos Flake
If you're using NixOS flakes, then the minimal configuration is.
```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    automous-zones.url = "github:the-computer-club/automous-zones";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    automous-zones,
    ...
  }: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        {
          networking.wireguard.interfaces.asluni = let
            # asluni can be anything.
            peers = inputs.automous-zones.flakeModules.asluni.wireguard.networks.asluni.peers.by-name;
            aslib = inputs.automous-zones.lib;
          in {
            privateKeyFile = "/var/lib/wireguard/key";
            generatePrivateKeyFile = true;
            peers = aslib.toNonFlakeParts peers; # this is where the magic happens
            ips = [ "<your-ip-address>/32" ];
          };
        }
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
```


### Using Flake-guard v1

https://github.com/the-computer-club/lynx/tree/main/flake-modules/flake-guard

This just reduces the need for setting up the private keying information yourself.

```nix
{ self, config, lib, pkgs, ... }:
let
  net = config.networking.wireguard.networks;
in
{
  imports = [ 
     self.nixosModules.flake-guard-host
     # at one point or another we depreciated `networking.wireguard.networks`
     # but is maintained on v1
     { networking.wireguard.networks = inputs.asluni.nixosModules.asluni.wireguard.networks;  }
  ];
  
  sops.secrets.asluni.mode = "0400";
  
  networking.firewall.interfaces = {
    eno1.allowedUDPPorts = [
      net.asluni.self.listenPort
    ];
    
    asluni.allowedTCPPorts = [ 22 80 443 ];
  };

  networking.wireguard.networks = {
    asluni.autoConfig = {
      interface = true;
      peers = true;
    };
  };
}
```

### Using Flake-guard v2
[see documentation for flake-guard v2](https://github.com/the-computer-club/lynx/blob/flake-guard-v2/flake-modules/flake-guard/docs/quickstart.md)

likewise

``` nix

{ self, config, lib, pkgs, ... }:
let
  net = config.networking.wireguard.networks;
in
{
  imports = [ 
     inputs.lynx.nixosModules.flake-guard-host
     inputs.asluni.nixosModules.asluni
  ];
  
  sops.secrets.asluni.mode = "0400";
  
  wireguard.defaults.autoConfig = {
    openFirewall = mkDefault true;

    "networking.wireguard" = {
      interface.enable = mkDefault true;
      peers.mesh.enable = mkDefault true;
    };

    "networking.hosts" = {
      FQDNs.enable = mkDefault true;
      names.enable = mkDefault true;
    };
  };
  
  wireguard.networks.asluni = {
    secretsLookup = "sopsValue";

    autoConfig."networking.wireguard" = {
      interface.enable = true;
      peers.mesh.enable = true;
    };
  };
}
```

