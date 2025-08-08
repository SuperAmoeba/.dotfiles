{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    rofi-wayland
    yazi
    #mako
    bat
    
  ];

  # Configs
  #programs.rofi = {
    #enable = true;
    
    #theme = "~/.dotfiles/hm-configs/theme_rofi/rofitheme.rasi"; # config when you have time
  #};

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      mgr = {
        show_hidden = true;
      
      };
      preview = {
        image_filter = "lanczos3";
      };
      opener = {
        play = [
          { run = "vlc \"$@\""; orphan = true; for = "unix"; }
        ];
        edit = [
          { run = "vim \"$@\""; block = true; for = "unix"; }
        ];
        open = [
          { run = "xdg-open \"$@\""; desc = "Open"; }
        ];
      };
    };

    flavors = {
      flexoki-dark = ./theme_yazi/flexoki-dark.yazi;
      catppuccin-macchiato = ./theme_yazi/catppuccin-macchiato.yazi;
    };
    theme = {
      flavor = { dark = "catppuccin-macchiato"; };
    };

  };

  programs.bat = {
    enable = true;
    
  };

}
