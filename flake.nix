
{
  outputs = _:
  {
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
          publicKey = "5j44nM6qmbJ2S8B24aA/H6UEPVXJFfxf8sTacMktMis=";
          ipv4 = [ "172.16.2.3/32" ];
          selfEndpoint = "98.46.211.251:63723";
        };

        hydrogen = {
          publicKey = "qXsTs+IsmHeq9+rulmG6M7XhVgu/3N/wEgEaHPuHciU=";
          ipv4 = [ "172.16.2.4/32" ];
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
      };
    };
  };
}

