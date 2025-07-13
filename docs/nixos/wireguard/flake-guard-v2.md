# Using Flake-guard v2
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
