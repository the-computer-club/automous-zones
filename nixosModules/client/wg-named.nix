{ config, lib, pkgs, ... }:
let
  peerNames =
    lib.foldl' lib.recursiveUpdate { }
      (lib.mapAttrsToList
        (network-name: network:
          lib.pipe network.peers.by-name [
            (lib.filterAttrs (k: v: v.publicKey != null))
            (lib.mapAttrs' (k: v: lib.nameValuePair v.publicKey { name = k; }))
          ]
        )
        config.wireguard.build.networks
      );
in
  {
    options.wireguard.named.enable =
      lib.mkEnableOption "enable names on 'wg show <interface|all>'";

    config = lib.mkIf config.wireguard.named.enable {
      environment.sessionVariables.WG_NAME = lib.mkDefault
        "path:///etc/wireguard/name.json";

      environment.etc."wireguard/name.json".source =
        builtins.toFile "name.json"
          (builtins.toJSON peerNames);

      environment.systemPackages = [
        config.flake.packages.x86_64-linux."python3/wg-name/wireguard-tools"
      ];
    };
  }
