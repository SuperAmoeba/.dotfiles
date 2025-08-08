{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    discord
    whatsapp-for-linux
    
  ];
}
