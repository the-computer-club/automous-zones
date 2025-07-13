self: { lib, pkgs, ... }:
let
  zones = self.asluni.zones;
  wgsd = self.packages.${pkgs.system}."coredns/wgsd";
in
{
  services.dns-forwarder = {
    listenPort = lib.mkDefault 5353;
    listenAddress = lib.mkDefault "172.16.2.2";
    forwardAddress = lib.mkDefault "172.16.2.2";
    forwardPort = lib.mkDefault 53;
    openFirewall = false;
  };

  services.nsd = {
    port = lib.mkDefault 5334;
    interfaces = [ "lo" ];
    zones = lib.mkDefault zones;
  };

  services.coredns = {
    extraArgs = lib.mkDefault [ "-dns.port=53" ];
    config = lib.mkDefault ''
      . {
        bind asluni
        wgsd luni.b32. asluni
        forward luni 127.0.0.1:5334 {
          policy sequential
        }
      }
    '';

    package = lib.mkDefault wgsd;
  };

  ####
  # NOTE: wgsd needs cap_net_admin to read the wireguard peers
  systemd.services.coredns.serviceConfig.CapabilityBoundingSet = lib.mkForce "cap_net_bind_service cap_net_admin";
  systemd.services.coredns.serviceConfig.AmbientCapabilities = lib.mkForce "cap_net_bind_service cap_net_admin";
}
