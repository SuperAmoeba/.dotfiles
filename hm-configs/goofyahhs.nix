{ config, pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    sl
    neo-cowsay
    fortune
    blahaj
    clolcat
    uwuify
    (import ./customs/trans-cmatrix.nix { inherit pkgs; })
    astroterm
    #(import ./customs/terminal-rain-lightning.nix { inherit pkgs; })
    
    
  ] ++
  [
    #inputs.momoiSay

  ];

}
