# asluni for windows


## Download & Install Wireguard

https://download.wireguard.com/windows-client/wireguard-amd64-0.5.3.msi

Open, Add tunnel, Name asluni, Edit, copy and paste peers from

https://github.com/the-computer-club/automous-zones/releases/download/latest/wg-asluni.conf

activate tunnel

## Test wireguard
```
ping 172.16.2.2
```


## Get DNSCrypt-proxy
Extract and CD into https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.1.12/dnscrypt-proxy-win64-2.1.12.zip


### Setup DNS forwarding
find the section named  "Forwarding" in example-proxydns-config.toml
and remove the # at the beginning like so
```
forwarding_rules = 'forwarding-rules.txt'
```
save and rename `example-dnsproxy-config.toml` to `dnsproxy-config.toml`

rename `example-forwarding-rules.txt` to `forwarding-rules.txt`

add the following to `forwarding-rules.txt`

```
luni     172.16.2.2:5334
luni.b32 172.16.2.2:5333
```

## Install DNS proxy as a service

```
install-service.bat
dnscrypt-proxy.exe -service start
```


## clear existing DNS records
(powershell)
```
wmic nicconfig where (IPEnabled=TRUE) call SetDNSServerSearchOrder ()
```

### set primary DNS to DNSProxy
(powershell)
```
wmic nicconfig where (IPEnabled=TRUE) call SetDNSServerSearchOrder ("127.0.0.1")
```

both commands should succeed
```
nslookup google.com
nslookup unallocatedspace.luni
```

open `mmc.exe`

Follow instructions here
https://www.sonicwall.com/support/knowledge-base/how-can-i-import-certificates-into-the-ms-windows-local-machine-certificate-store/170504615105398

with the exemption of the slide

https://sonicwall.rightanswers.com/portal/app/portlets/results/onsitehypermedia/090170803312789.png?linkToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzb25pY3dhbGwiLCJpYXQiOjE3NDkxMjcyNjcsImV4cCI6MTc4MDY2MzI2N30.U4nCBU5-rCtsmwMexJl_PMLfTpo-QmbDNPp-XhZlFhA

where infact, you instead use the first modal option.


## Root_CA.crt
```
-----BEGIN CERTIFICATE-----
MIIBfDCCASGgAwIBAgIQWqMOZzNfWUND5wu1M/arNjAKBggqhkjOPQQDAjAcMRow
GAYDVQQDExFMdW5pTmV0IFJvb3QgQ2VydDAeFw0yNTAzMjgwMzI1MDhaFw0zNTAz
MjYwMzI1MDhaMBwxGjAYBgNVBAMTEUx1bmlOZXQgUm9vdCBDZXJ0MFkwEwYHKoZI
zj0CAQYIKoZIzj0DAQcDQgAEhINKEPodjC8yHP7ezDFloGdnNGB+g9QntuUSlTQm
zP+p+zuPJJG6Gn+EiuU+09GQ6fPyYe8Vwr6SJOQd5YpA06NFMEMwDgYDVR0PAQH/
BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFCN+JPhovFdnm8Zu
YwAYcPR28PVRMAoGCCqGSM49BAMCA0kAMEYCIQDMxtxApt363genVVthPKHNcfa2
32tLmdJiYsrr6aRdCwIhAKspcXS8VbEhXgSAHW79ElagYTPR+kraJ3eWJGzWa11C
-----END CERTIFICATE-----
```

## allocatedspace_ca.crt
```
-----BEGIN CERTIFICATE-----
MIIBqzCCAVGgAwIBAgIQQ0GM0vSy6gVrpeLwjXp/PjAKBggqhkjOPQQDAjAcMRow
GAYDVQQDExFMdW5pTmV0IFJvb3QgQ2VydDAeFw0yNTAzMjgwMzMxMDRaFw0zNTAz
MjYwMzMxMDRaMCsxKTAnBgNVBAMTIEx1bmlOZXQgQ0EgdW5hbGxvY2F0ZWRzcGFj
ZS5sdW5pMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAENpsRx14ka0fieNqYsnAb
Z13geXRXvR5n9YJ1m8AbbiT4uWVF3N6OVDrrHcV9ERLu7VY8lI8ojSjAWWuAdakp
faNmMGQwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0O
BBYEFAs68DLCS663P33Xst4IavptFSN7MB8GA1UdIwQYMBaAFCN+JPhovFdnm8Zu
YwAYcPR28PVRMAoGCCqGSM49BAMCA0gAMEUCIQDpwXDQL2Fzjrln1ginaeTqq7dF
QzREttzO8ulAkNoRiwIgCaflXonMtBg2XLRqOKo28XHbKcwHsrzKEPCapDNGmk4=
-----END CERTIFICATE-----
```

## *.unallocatedspace.luni
```
-----BEGIN CERTIFICATE-----
MIIB+DCCAZ6gAwIBAgIRAJFPCAVV1J7GLnYZAX5ZygAwCgYIKoZIzj0EAwIwKzEp
MCcGA1UEAxMgTHVuaU5ldCBDQSB1bmFsbG9jYXRlZHNwYWNlLmx1bmkwHhcNMjUw
MzMxMDMzMDI1WhcNMjYwMzMxMDMzMDI1WjAgMR4wHAYDVQQDExV1bmFsbG9jYXRl
ZHNwYWNlLmx1bmkwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAASMXcx4ci9Bzyuj
CjdJTLGm43eDZ47iB4LVRxWuNNLyaKqEuuuGTQOMcCBURULM1r586/kmnyEwD0Cy
6tj26VJlo4GtMIGqMA4GA1UdDwEB/wQEAwIHgDAdBgNVHSUEFjAUBggrBgEFBQcD
AQYIKwYBBQUHAwIwHQYDVR0OBBYEFFZ27GrDg0dJzX4NqPL57EcV5wruMB8GA1Ud
IwQYMBaAFAs68DLCS663P33Xst4IavptFSN7MDkGA1UdEQQyMDCCFXVuYWxsb2Nh
dGVkc3BhY2UubHVuaYIXKi51bmFsbG9jYXRlZHNwYWNlLmx1bmkwCgYIKoZIzj0E
AwIDSAAwRQIgC7juhHJ6Oq7YxS8pnOgX3E4RcKioOEsJxdU7OnYEl1kCIQCg8gjo
1NekATpgXlm/k8S81HrGOdAe4cKA8AA+SHHE0w==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIBqzCCAVGgAwIBAgIQQ0GM0vSy6gVrpeLwjXp/PjAKBggqhkjOPQQDAjAcMRow
GAYDVQQDExFMdW5pTmV0IFJvb3QgQ2VydDAeFw0yNTAzMjgwMzMxMDRaFw0zNTAz
MjYwMzMxMDRaMCsxKTAnBgNVBAMTIEx1bmlOZXQgQ0EgdW5hbGxvY2F0ZWRzcGFj
ZS5sdW5pMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAENpsRx14ka0fieNqYsnAb
Z13geXRXvR5n9YJ1m8AbbiT4uWVF3N6OVDrrHcV9ERLu7VY8lI8ojSjAWWuAdakp
faNmMGQwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0O
BBYEFAs68DLCS663P33Xst4IavptFSN7MB8GA1UdIwQYMBaAFCN+JPhovFdnm8Zu
YwAYcPR28PVRMAoGCCqGSM49BAMCA0gAMEUCIQDpwXDQL2Fzjrln1ginaeTqq7dF
QzREttzO8ulAkNoRiwIgCaflXonMtBg2XLRqOKo28XHbKcwHsrzKEPCapDNGmk4=
-----END CERTIFICATE-----
```


## Test the connection
```
curl unallocatedspace.luni
```
