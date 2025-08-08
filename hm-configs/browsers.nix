{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    librewolf
    brave
    
  ];

  # Configs
  programs.librewolf = {
    enable = true;
    
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
    };
  };
}
