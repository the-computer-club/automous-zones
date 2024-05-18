{ self, ...}:
with builtins;
with self.lib;
let
  config = self.flakeModules.asluni.wireguard.networks;

  perNetwork  = c: f: mapAttrs f c;
  perPeer     = f: network: (mapAttrs f) network.peers.by-name;
  perNetworkPeer = c: f: perNetwork c (name: net: (perPeer f net));

  check = {
    network-name
    , peers-by-name
    , msg
  }:
    all (mapAttrsToList (k: v:
      if v then true
      else
        builtins.throw "${network-name}: ${k}: ${msg}"
      ) peers-by-name
    );

  perNetwork' = (perNetwork config);
  perNetworkPeer' = (perNetworkPeer config);
  test.network.uniqueIP =
     mapAttrs (k1: v1:
        mapAttrs (k: v: ! (elem v v1))
          allocatedspace
      ) allocatedspace;

in
{

  asluni.looksLikeIpv4-32=
    perPeer
      (name: peer:
        map (x: match "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/32" x)
          peer.ipv4
      )
      config.asluni
  ;

  everyNetwork.uniqueIP =
    let
      parted =
        perNetwork' (k: net:
          foldl' (s: peer:
            let
              seen = p: (x: elem x s.ips) p.value;
              parted = partition seen peer;
            in
              {
                right = parted.right ++ s.right;
                wrong = parted.wrong ++ s.wrong;
                ips = s.ips ++ peer.value;
              }
          )
          {wrong = []; right = []; ips=[];}
          (mapAttrsToList (k: v: {
            value = v.ipv4;
            key = k;
          }) net.peers.by-name)
        );
    in
      parted.wrong != [];

  everyNetwork.keyLength = perNetworkPeer' (name: peer: (length peer.publicKey) == 32);
  everyNetwork.ipsIsList = perNetworkPeer' (name: peer: isList peer.ipv4);
  everyNetwork.ipsIsNotEmpty = perNetworkPeer' (name: peer: peer.ipv4 != []);

}
