
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


# wg-quick

to generate a wg-quick configuration from source [ temporary solution ]
```
nix eval github:the-computer-club/automous-zones#nixosModules.asluni.wireguard.networks.asluni.peers.by-name --apply "x: {Peer = builtins.attrValues ((builtins.mapAttrs(name: peer: { AllowedIPs = peer.ipv4; PublicKey = peer.publicKey; } // (if peer ? selfEndpoint then { Endpoint = peer.selfEndpoint; } else {}) )) x);}" --json | remarshal --if json --of toml | sed 's/"//g' | sed 's/\[\[/\[/g' | sed 's/\]\]/\]/g' | sed "s/\[1/1/" | sed "s/2\]/2/g"
```


if you're not using nix, [then the configuration is generate](https://github.com/the-computer-club/automous-zones/releases/download/latest/wg-asluni.conf)


## Automatically update
```
#!/usr/bin/env sh

curl https://github.com/the-computer-club/automous-zones/releases/download/latest/wg-asluni.conf > /tmp/latest-asluni.conf

cat /var/secrets/asluni.tmpl /tmp/latest-asluni.conf > /var/lib/wireguard/asluni.conf

rm /tmp/latest-asluni.conf
```



