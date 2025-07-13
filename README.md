# automous-zones
A P2P wireguard mesh network that underpins computer-club infrastructure. Its used as tunneling layer that lets us play games, share files, host services, etc.

To Join add yourself to the peer list inside `flake.nix`

- 1) Fork this repository,
- 2) Generate a wireguard key, 
- 3) Determine the next available IP address.
- 4) Fill in the following information
``` nix
  ...
  peers.by-name = {
    ...
    hostname = {
      publicKey = "..."; # wg genkey | tee private-key | wg pubkey
      ipv4 = [ "172.16.2.XX/32" ];
    };
    ...
  };
```

- 5) Make sure you're in order of IP address.
- 6) Setup a pull request on this repository.

And you're done.

## Support options
----

### wg-quick

wg-quick configuration [wg-asluni.conf](https://github.com/the-computer-club/automous-zones/releases/download/latest/wg-asluni.conf)

#### To automatically update
```sh
#!/usr/bin/env sh
curl https://github.com/the-computer-club/automous-zones/releases/download/latest/wg-asluni.conf > /tmp/latest-asluni.conf
cat /var/secrets/asluni.tmpl /tmp/latest-asluni.conf > /var/lib/wireguard/asluni.conf
rm /tmp/latest-asluni.conf
```


#### build from source
```sh
nix eval github:the-computer-club/automous-zones#nixosModules.asluni.wireguard.networks.asluni.peers.by-name --apply "x: {Peer = builtins.attrValues ((builtins.mapAttrs(name: peer: { AllowedIPs = peer.ipv4; PublicKey = peer.publicKey; } // (if peer ? selfEndpoint then { Endpoint = peer.selfEndpoint; } else {}) )) x);}" --json | remarshal --if json --of toml | sed 's/"//g' | sed 's/\[\[/\[/g' | sed 's/\]\]/\]/g' | sed "s/\[1/1/" | sed "s/2\]/2/g"
```


