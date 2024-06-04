
## helper function demo
Currently, this repo is designed to work with Flake-gaurd out of the box. However, the following demo below shows the included helper function in action to convert the data for non flake-part Flake-gaurd users.

## flake
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
