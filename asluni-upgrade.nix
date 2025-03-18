{
  wireguard.networks.asluni.peers.by-name = {
    domainName = "luni";
    metadata.authority = {
      rootCertificate = ./root-ca.crt;
      subca."acme.luni" = {
        certificate = ./acme.luni.crt;
        endpoint = "https://acme.luni:8443/acme/acme/directory";
      };
    };

    cardinal.extraHostNames = [
      "acme.luni"
      "cardinal.m1000.us-chi.turn.luni"
    ];

    "vxgw1.unallocatedspace.dev".ignoreHostName = true;
    "jita.etherealryft.net".ignoreHostName = true;

    cypress.extraHostNames = [
      "cypress.local"
      "chat.cypress.local"
      "sesh.cypress.local"
      "buildbot.cypress.local"
      "tape.cypress.local"
      "codex.cypress.local"
      "cache.cypress.local"
      "discord-media.cypress.local"
      "pgadmin.cypress.local"
      "cockpit.cypress.local"
      "metrics.cypress.local"
      "cypress.buildbot.luni"
      "download.coggiebot.cypress.luni"
    ];

    artix.extraHostNames = [
      "git.luni"
      "buildbot.luni"
      "pastebin.luni"
      "artix.m1000.us-chi.turn.luni"
    ];
  };
}
