with builtins;
rec {
  mapAttrsToList = f: attrs: map (name: f name attrs.${name}) (builtins.attrNames attrs);

  flatten = x:
      if isList x
      then concatMap (y: flatten y) x
      else [x];

  toPeers = n: v: {
        publicKey = v.publicKey;
        allowedIPs = v.ipv4;
        endpoint = v.selfEndpoint or null;
      };

  toNonFlakeParts = data: (mapAttrsToList toPeers data);
}
