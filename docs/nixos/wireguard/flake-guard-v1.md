# Flake-guard v1


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



