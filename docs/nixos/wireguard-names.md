# Wireguard names

![screenshot](imgs/image.png?height=100)

try it out before you buy it.
```sh
WG_NAME="https://github.com/the-computer-club/automous-zones/releases/download/latest/name.json" sudo -E nix run github:the-computer-club/lynx/flake-guard-v2#wireguard-tools -- show
```

### NixOS
---
If you include `inputs.flake-guard-v2.url = github:the-computer-club/lynx/flake-guard-v2` 
as an input to your flake, it provides `packages.x86_64-linux.wireguard-tools`

```
imports = [ inputs.asluni.nixosModules.wg-named ];
```


### Manual

### Linux
---
Download `pkgs/wg-name/wg-name` from flake-guard-v2

Create this file

```sh
#!/usr/bin/env sh
# wireguard-entry-point.sh
excludeWord=( interfaces -h --help )
if [[ "\$1" == "show" ]]; then
  if [[ " ${excludeWord[*]} " =~ " $2 " ]] || [[ "$3" != "" ]]; then
    /bin/wg-original ${@:1}
    exit 0
  fi
  PROGRAM="wg-original" /bin/wg-name ${@:2}
else /bin/wg-original ${@:1}
fi
```

And then do the following installation
```sh
mv /bin/wg /bin/wg-original
mv wg-name /bin/wg-name
mv wireguard-entry-point.sh /bin/wg

chmod +x /bin/wg /bin/wg-name
chown root:root /bin/wg /bin/wg-name

echo "WG_NAME=https://github.com/the-computer-club/automous-zones/releases/download/latest/name.json" >> ~/.profile
```

Now run.
```sh
sudo wg show
```
should show names as seen above in the screenshot
