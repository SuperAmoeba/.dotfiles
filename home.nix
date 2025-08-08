{ config, pkgs, ... }:

{
  imports = [
    ./hm-configs/sh.nix
    ./hm-configs/musics/musics.nix
    ./hm-configs/pythons/pythons.nix
    ./hm-configs/messengers.nix
    ./hm-configs/browsers.nix
    ./hm-configs/mediaplayers.nix
    ./hm-configs/kdes.nix
    ./hm-configs/goofyahhs.nix
    ./hm-configs/hacks.nix
    ./hm-configs/utils.nix
    ./hm-configs/gaming.nix
    
    
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "amoeba";
  home.homeDirectory = "/home/amoeba";
  
  nixpkgs.config.allowUnfree = true;

  # GITHUB
  programs.git = {
    enable = true;
    userName = "SuperAmoeba";
    userEmail = "superamoeba.mc@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      # if problems with git commands, go to "Manage Your NixOS Config with Git" 11:30
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    fastfetch
    btop
        
    thunderbird
    rnote
    obsidian
    #logseq
    p3x-onenote
    vscodium

    pastel

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/amoeba/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.thunderbird = {
    enable = true;

    profiles = {
      "SuperAmoeba".isDefault = false;
      "RWTH".isDefault = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #FASTFETCH
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = "~/.dotfiles/hm-configs/extras/astolfo_trans.png";
        width = 35;
      };
      display = {
        separator = " ";
        color = "#5BCEFA";
      };
      #playerName = "mpd";
      modules = [
        { type = "title"; color = "#5BCEFA"; }

        { type = "break"; }

        { type = "os"; key = ""; keyColor = "#F5A9B8"; }
        { type = "kernel"; key = ""; keyColor = "#F5A9B8"; }
        { type = "packages"; key = ""; keyColor = "#F5A9B8"; }
        { type = "shell"; key = ""; keyColor = "#F5A9B8"; }
        { type = "terminal"; key = ""; keyColor = "#F5A9B8"; }
        { type = "wm"; key = ""; keyColor = "#F5A9B8"; }
        { type = "theme"; key = ""; keyColor = "#F5A9B8"; }
        { type = "font"; key = ""; keyColor = "#F5A9B8"; }
        { type = "uptime"; key = ""; keyColor = "#F5A9B8"; }
        { type = "datetime"; key = ""; keyColor = "#F5A9B8"; format = "{11}-{3}-{1}"; }
        { type = "datetime"; key = "󱑍"; keyColor = "#F5A9B8"; format = "{16}:{18}:{20}"; }
        #"player"
        #"media"

        { type = "break"; }

        { type = "cpu"; key = ""; keyColor = "#5BCEFA"; }
        { type = "gpu"; key = ""; keyColor = "#5BCEFA"; }
        { type = "memory"; key = ""; keyColor = "#5BCEFA"; }
        { type = "disk"; key = ""; keyColor = "#5BCEFA"; }

        { type = "break"; }

        { type = "colors"; symbol = "block"; spacing = 1; }
      ];
    };
  }; 
 
  #BTOP
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "/nix/store/pq5wcfcqs2crh7s4ngcvscq7acqz7kq8-btop-1.4.3/share/btop/themes/kyli0x.theme";
      theme_background = false;
      truecolor = true;
      force_tty = false;
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
      vim_keys = false;
      rounded_corners = true;
      graph_symbol = "braille";
      graph_symbol_cpu = "default";
      graph_symbol_gpu = "default";
      graph_symbol_mem = "default";
      graph_symbol_net = "default";
      graph_symbol_proc = "default";
      shown_boxes = "cpu mem proc";
      update_ms = "2000";
      proc_sorting = "pid";
      proc_reversed = false;
      proc_tree = false;
      proc_colors = true;
      proc_gradient = true;
      proc_per_core = true;
      proc_mem_bytes = true;
      proc_cpu_graphs = true;
      proc_info_smaps = false;
      proc_left = false;
      proc_filter_kernel = false;
      proc_aggregate = false;
      cpu_graph_upper = "Auto";
      cpu_graph_lower = "Auto";
      show_gpu_info = "Auto";
      cpu_invert_lower = true;
      cpu_single_graph = false;
      cpu_bottom = false;
      show_uptime = true;
      check_temp = true;
      cpu_sensor = "Auto";
      show_coretemp = true;
      cpu_core_map = "";
      temp_scale = "celsius";
      base_10_sizes = false;
      show_cpu_freq = true;
      clock_format = "%X";
      background_update = true;
      custom_cpu_name = "";
      disks_filter = "";
      mem_graphs = true;
      mem_below_net = false;
      zfs_arc_cached = true;
      show_swap = true;
      swap_disk = true;
      show_disks = true;
      only_physical = true;
      use_fstab = true;
      zfs_hide_datasets = false;
      disk_free_priv = false;
      show_io_stat = true;
      io_mode = false;
      io_graph_combined = false;
      io_graph_speeds = "";
      net_download = "100";
      net_upload = "100";
      net_auto = true;
      net_sync = true;
      net_iface = "";
      base_10_bitrate = "Auto";
      show_battery = true;
      selected_battery = "Auto";
      show_battery_watts = true;
      log_level = "WARNING";
      nvml_measure_pcie_speeds = true;
      rsmi_measure_pcie_speeds = true;
      gpu_mirror_graph = true;
      custom_gpu_name0 = "";
      custom_gpu_name1 = "";
      custom_gpu_name2 = "";
      custom_gpu_name3 = "";
      custom_gpu_name4 = "";
      custom_gpu_name5 = "";
    };
  };
}
