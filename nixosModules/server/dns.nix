self: { lib, pkgs, ... }:
let
  zones = self.asluni.zones;
  wgsd = self.packages.${pkgs.system}."coredns/wgsd";
in
{
  services.dns-forwarder = {
    listenPort = 5353;
    listenAddress = "172.16.2.2";
    forwardAddress = "172.16.2.2";
    forwardPort = 53;
    openFirewall = false;
  };

  services.nsd = {
    port = 5334;
    interfaces = [ "lo" ];
    inherit zones;
  };

  services.coredns = {
    extraArgs = [ "-dns.port=53" ];
    config = ''
      . {
        bind asluni
        wgsd luni.b32. asluni
        forward luni 127.0.0.1:5334 {
          policy sequential
        }
      }
    '';

    package = wgsd;
  };

  networking.firewall.interfaces.asluni.allowedUDPPorts = [ 53 5353 ];

  ####
  # NOTE: wgsd needs cap_net_admin to read the wireguard peers
  systemd.services.coredns.serviceConfig.CapabilityBoundingSet = lib.mkForce "cap_net_bind_service cap_net_admin";
  systemd.services.coredns.serviceConfig.AmbientCapabilities = lib.mkForce "cap_net_bind_service cap_net_admin";
}
