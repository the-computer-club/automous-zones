
{
  outputs = _:
  let
    mapAttrsToList = f: attrs: map (name: f name attrs.${name}) (builtins.attrNames attrs);
    toPeers = n: v: {
      publicKey = v.publicKey;
      allowedIPs = v.ipv4 ++ v.ipv6;
      endpoint = v.selfEndpoint or null;
      persistentKeepalive = v.persistentKeepalive or null;
    };
    toNonFlakeParts = data: (mapAttrsToList toPeers data);
  in
  {
    lib = { inherit toPeers toNonFlakeParts; };
    flakeModules.asluni = ./peers.nix;
    nixosModules.asluni = ./peers.nix;

    modules.nixos.asluni = ./peers.nix;
    modules.flake.asluni = ./peers.nix;

    flakeModules.asluni-v2 = /asluni-upgrade.nix;
    nixosModules.asluni-v2 = /asluni-upgrade.nix;
    modules.nixos.asluni-v2 = /asluni-upgrade.nix;
    modules.flake.asluni-v2 = /asluni-upgrade.nix;
  };
}
