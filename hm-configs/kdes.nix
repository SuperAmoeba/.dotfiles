{ config, pkgs, ... }:
{
  home.packages = with pkgs.kdePackages; [
    kate
    kolourpaint
    filelight
    
  ];
}
