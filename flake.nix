{
  outputs = _:
  {
    flakeModules.asluni = {
      wireguard.networks.asluni = {
        sopsLookup = "legacynet";
        listenPort = 63723;

        peers.by-name = {
          cardinal = {
              publicKey = "jnXKmN44kEFqLjazq77764oFfvl4c748YAfBFBNyKHQ=";
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
            ipv4 = [ "172.16.2.5/32" ];
          };
        };
      };
    };
  };
}
