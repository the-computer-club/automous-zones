
## helper function demo
Currently, this repo is designed to work with Flakegaurd out of the box. However, the following demo below shows the included helper function in action to convert the data for non flake-part Flakegaurd users.

```nix
networking.wireguard.interfaces = let
 peers = inputs.automous-zones.flakeModules.asluni.wireguard.networks.asluni.peers.by-name;
 azlib = inputs.automous-zones.lib;
in {
    networking.wireguard.interfaces.wg0 = {
        peers = azlib groups; 
    };
};
```