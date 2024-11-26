{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    firewall.allowedTCPPorts = [ 443 80 26656 22 ];
    defaultGateway = "172.31.1.1";
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="23.88.101.17"; prefixLength=32; }
        ];
        ipv6.addresses = [
          { address="2a01:4f8:c0c:491d::1"; prefixLength=64; }
{ address="fe80::9400:3ff:fee0:5c09"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "172.31.1.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "fe80::1"; prefixLength = 128; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="96:00:03:e0:5c:09", NAME="eth0"
    
  '';
}