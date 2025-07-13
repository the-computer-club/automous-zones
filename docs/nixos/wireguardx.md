# Quick start: Nixos Client

setting up wireguard.
```
imports = with inputs.asluni.nixosModules; [ 
    client

    ## use peers.by-name when running `wg show`
    # client-named-peers

    ### choose your DNS support
    # client-dns-dnscrypt <- preconfigured doh with luninet forwarding.
    # client-dns-resolvconf <- use /etc/resolv.conf
    # client-dns-resolved <- systemd-resolved
    ###
];

# Secrets for wireguard network. 
# (assumes wireguard name by default.)
sops.secrets.asluni = {};


```
