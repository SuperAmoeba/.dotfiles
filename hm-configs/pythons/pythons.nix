{ config, pkgs, ... }:

{
  #mudar aqui quando for um python novo
  home.packages = with pkgs.python313Packages; [
    python
    eyed3
    pipx
        
  ];

}
