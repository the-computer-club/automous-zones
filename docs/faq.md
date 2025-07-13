# FAQ

What do you have access to:
  - whatever peers have known endpoints is what you can reach at any given time.
  - some peers have `selfEndpoint` which lets you connect to them anytime.
  - All the IP addresses under 172.16.2.1 - 172.16.2.254 are routed under the VPN, which is everything you potentially have access to.
  
Can people connect to me without me knowing:
  - No one can connect to you.
  
    Except, on the occasion that you try connecting to a peer with `selfEndpoint` defined, or yourself have defined `selfEndpoint`. Then in fact, they can connect back to you while a pathway is established.
  
    If this is of concern to you, 
    make sure to include firewall rules at the endpoint which is hosting the private key to drop incoming connections. (This is the default policy on most OS's)

Can I turn off wireguard?:
  - You absolutely do not need this VPN running all the time.

Does this mask my traffic like NordVPN?:
  - No, we do not forward public WAN traffic. The setup is a split VPN

What is a split VPN?:
  - A split VPN is a configuration where sometimes traffic is encapsulated. 
  In the case of this network, only 172.16.2.0/24 is encapsulated, so only packets
  addressed to them will be sent through the VPN.
  
Why can I not ping anyone?:
  - If you were just recently added to the peer list, everyone who you wish to connect to must first update their peer list with your newly added keys. Some peers may never include your keys on the interface. If you lost access to a particular peer, try updating this configuration. They may updated their configuration.

