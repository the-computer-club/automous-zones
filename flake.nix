
{
  outputs = _:
  let
    mapAttrsToList = f: attrs: map (name: f name attrs.${name}) (builtins.attrNames attrs);
    toPeers = n: v: {
      publicKey = v.publicKey;
      allowedIPs = v.ipv4;
      endpoint = v.selfEndpoint or null;
    };
    toNonFlakeParts = data: (mapAttrsToList toPeers data);
  in 
  {
    lib = {
      inherit toPeers toNonFlakeParts;
    };
    flakeModules.asluni.wireguard.networks.asluni = {
      listenPort = 63723;
      peers.by-name = {
        cardinal = {
            publicKey = "2Q5yU5ueoDcEc+Segj/FJZ61IIiLWUVHtzf4uV31NjI=";
            ipv4 = [ "172.16.2.1/32" ];
            selfEndpoint = "unallocatedspace.dev:63723";
        };

        artix = {
          publicKey = "3CThsm++hbh48Oe7BX6PNQhUyWoCMsaq3gd0KvCoITM=";
          ipv4 = [ "172.16.2.2/32" ];
          selfEndpoint = "23.94.99.203:63723";
        };

        cypress = {
          publicKey = "nvuYPHJ2BUjXGyUMwr03XZYTMZGSQDyv3vDfZpGzfwo=";
          ipv4 = [ "172.16.2.3/32" ];
          selfEndpoint = "98.46.211.251:63723";
        };

        hydrogen = {
          publicKey = "qXsTs+IsmHeq9+rulmG6M7XhVgu/3N/wEgEaHPuHciU=";
          ipv4 = [ "172.16.2.4/32" ];
        };
        
        sky = {
          publicKey = "EF4+fPzrAMqasS8Z7auajOuHmcvqcHVGQNPwhPo0/U8=";
          ipv4 = [ "172.16.2.42/32" ];
        };

        simcra = {
          publicKey = "iKKn0hxQdScrXXkpmIC83Zgo0Y3GexCQ4+Qd/6NryUc=";
          ipv4 = [ "172.16.2.64/32" ];
        };

        quantum = {
          publicKey = "FuOo9TwnE8P/zDBorjGNtsyPImHsHPxA21ePNrElsD0=";
          ipv4 = [ "172.16.2.5/32" ];
        };

        flagship = {
          publicKey = "qHQIOwGK7+6hXuBr6g1U00IzOM1p7Wc/ov/svPom0A8=";
          ipv4 = [ "172.16.2.6/32" ];
        };

        goatware = {
          publicKey = "YO5w0tMvPt2lDdg9eD25wZsz9rWMTGbA/KuPYB6F1jQ=";
          ipv4 = ["172.16.2.7/32"];
        };

        pager1 = {
          publicKey = "NEN3VPGm58JLQkjUwq8MOhC/d7ZEZXcIjBl84ENGBzg=";
          ipv4 = ["172.16.2.8/32"];
        };

        "0xc000000f" = {
          publicKey = "58qZ8KjLz80JPfSgsWU7iPpS6bjy94NONVoufLGxeX4=";
          ipv4 = ["172.16.2.10/32"];
        };

        frogson = {
          publicKey = "5j44nM6qmbJ2S8B24aA/H6UEPVXJFfxf8sTacMktMis=";
          ipv4 = ["172.16.2.69/32"];
        };
 
        "jita.etherealryft.net" = {
          publicKey = "Ngp854R/d126OVrO7nRv0yj8rdHRjGURa5LbD/UT8Xk=";
          selfEndpoint = "72.55.233.131:56854";
          ipv4 = ["172.16.2.71/32"];
        };
      };
    };
  };
}
