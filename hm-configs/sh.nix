{ config, pkgs, ... }:
let
  myAliases = {
    rb = "sudo nixos-rebuild switch --flake /home/amoeba/.dotfiles/";
    hm = "home-manager switch --flake /home/amoeba/.dotfiles/";
    ga = "git add -A";
    gc = "git commit -m"; #remember to still add the message
    gp = "git push github main";
    cls = "clear";
    my_tag_genres = "~/.dotfiles/hm-configs/musics/utils/my_tag_genres.sh ./";
    tag_genres = "~/.dotfiles/hm-configs/musics/utils/tag_genres.sh ./";
    fetch_lyrics = "~/.dotfiles/hm-configs/musics/utils/fetch_album_lyrics.sh ./";
    my_fetch_lyrics = "~/.dotfiles/hm-configs/musics/utils/my_fetch_album_lyrics.sh ./";
    coverjpg = "~/.dotfiles/hm-configs/musics/utils/album_art_add_jpg.sh";
    coverpng = "~/.dotfiles/hm-configs/musics/utils/album_art_add_png.sh";
    coverflacjpg = "~/.dotfiles/hm-configs/musics/utils/album_art_add_flac_jpg.sh";
    coverflacpng = "~/.dotfiles/hm-configs/musics/utils/album_art_add_flac_png.sh";

  };
in
{
  #KITTY
  programs.kitty = {
    enable = true;

    shellIntegration = {
      enableFishIntegration = true;
      #enableBashIntegration = true;
      #enableZshIntegration = true;
    };
    #enableGitIntegration = true;

    settings = {
      enable_graphics = "yes";
      # font
      font_family = "Monocraft"; #probably already does all, but jic
      bold_font = "Monocraft-Bold";
      italic_font = "Monocraft-Italic";
      bold_italic_font = "Monocraft-Bold-Italic";
      #font_family = "Caskaydia Cove Nerd Font";
      #bold_font = "Caskaydia Cove Nerd Font Bold";
      #italic_font = "Caskaydia Cove Nerd Font Italic";
      #bold_italic_font = "Caskaydia Cove Nerd Font Bold Italic";
      font_size = "12.0";

      # cursor
      cursor = "#FFA500";
      cursor_shape = "beam"; #Yuh, I just pulled up on 'em with a BEAM, BEAM, BEAM!
      cursor_blink_interval = "1";

      # sound
      enable_audio_bell = "no";

      # window layout
      # maybe do in combination with sway?

      # color scheme
      background_opacity = "0.65";
      #background_blur = "64"; # HELP -> ASK JONAS HOW TO ON WAYLAND
      #selection_foreground = "";
      #selection_background = "";
      color5 = "#d68a9d";
      color13 = "#f5a9b8";
      color6 = "#4da8d6";
      color14 = "#5bcefa";
      color7 = "#dddddd";
      color15 = "#ffffff";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+shift+esc" = "launch btop";
    };
  };

  #FISH  
  programs.fish = {
    enable = true;

    shellAliases = myAliases;    

    functions = {
      fish_greeting = "fastfetch\necho 'Hey there, cutie :3 (fish)'";
    };
  };

  #BASH
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
    initExtra = "echo 'Hey there, cutie :3 (bash)'";
  };

  #ZSH
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
}  
