# DNS setup guide.


### resolv.conf

``` sh
echo "nameserver 172.16.2.2" | resolvconf -a asluni -m 0 -x
```

### systemd-resolved

```sh
sudo systemd-resolve -i asluni --set-dns=172.16.2.6:5333 --set-dns=172.16.2.6:5334
resolvectl domain asluni luni. _wireguard._udp.luni.b32.
```

### dnscrypt

```nix
services.dnscrypt-proxy2.settings.forwarding = pkgs.writeText "forwarding_rules.txt" ''
  luni 172.16.2.2:5334
  luni.b32 172.16.2.2:5333
'';
```

