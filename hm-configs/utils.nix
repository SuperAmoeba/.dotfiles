{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    fuzzel
    yazi
    #mako
    bat
    
  ];

  # Configs
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        anchor = "center";
        lines = "10";
        font = "Monocraft";
        use-bold = true;
      };
      colors = {
        background = "282a36dd";
        text = "f8f8f2ff";
        #prompt = "bd93f9ff";
        #input = "ffffffff";
        match = "bd93f9ff";
        selection = "44475add";
        selection-text = "f8f8f2ff";
        selection-match = "bd93f9ff";
        border = "bd93f9ff";
      };
    };
  };

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
