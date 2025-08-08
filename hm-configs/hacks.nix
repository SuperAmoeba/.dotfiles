{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    jadx
    imhex
    # wireshark isn't supported by hm
    
  ];
}
