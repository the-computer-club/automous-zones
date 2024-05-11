
## helper function demo
Currently, this repo is designed to work with Flake-gaurd out of the box. However, the following demo below shows the included helper function in action to convert the data for non flake-part Flake-gaurd users.

```nix
networking.wireguard.interfaces.asluni = let # asluni can be anything.
 peers = inputs.automous-zones.flakeModules.asluni.wireguard.networks.asluni.peers.by-name;
 aslib = inputs.automous-zones.lib;
in {
    peers = aslib.toNonFlakeParts peers; 
};
```