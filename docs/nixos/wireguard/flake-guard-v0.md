# Nixos Flake

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
            ips = [ "<your-ip-address>/32" ];
            privateKeyFile = "/var/lib/wireguard/key";
            generatePrivateKeyFile = true;
            peers = 
                inputs.automous-zones.lib.toNonFlakeParts 
                    peers; # this is where the magic happens
          };
        }
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
```
