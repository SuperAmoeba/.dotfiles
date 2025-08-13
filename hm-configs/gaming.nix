{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lunar-client
    #_4d-minesweeper

  ];
}
