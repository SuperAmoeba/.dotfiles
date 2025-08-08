{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    feh
    vlc

  ];

  # Configs
  programs.feh = {
    enable = true;
    
  };
    
}
