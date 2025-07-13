# DNS

### resolv.conf
unsupported atm since our dns server doesn't sit on port 53.

but when supported will be
``` sh
# currently unsupported.
echo "nameserver 172.16.2.2" | resolvconf -a asluni -m 0 -x
```

### systemd-resolved
run the following to attach the dns & domain zone to the interface.
```sh
sudo systemd-resolve -i asluni --set-dns=172.16.2.6:5333 --set-dns=172.16.2.6:5334
resolvectl domain asluni luni. _wireguard._udp.luni.b32.
```

## dnscrypt
if you're using dnscrypt-proxy2 then simply add the following.
```nix
services.dnscrypt-proxy2.settings.forwarding = pkgs.writeText "forwarding_rules.txt" ''
  luni 172.16.2.2:5334
  luni.b32 172.16.2.2:5333
'';
```

## wg-quick
simply add both servers to the dns section of the file.
