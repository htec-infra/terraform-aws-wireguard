# Wireguard Terraform module

Wireguard module installs the Wireguard VPN Server on the Ubuntu 20.04 AMI along with 
[Subspace UI](https://github.com/subspacecommunity/subspace) that is used to manage Wireguard's Peer keys.

```
Note: This module disables DNS service deployed on the Subspace docker container because of conflicts
with the EC2 system-resolver service.  
```

