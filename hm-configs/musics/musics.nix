{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    mpd
    rmpc
    cava
    spek
    flac

  ];  

  # CAVA
  programs.cava = {
    enable = true;

    settings = {
      general = {
        framerate = "60";
        #use_borders = 0;
        #use_legacy = 0;
        max_height = "100";
        #mode = "normal";
      };
      input.method = "pipewire";
      color = {
        gradient = "1";
        gradient_color_1 = "'#5bcefa'";
        gradient_color_2 = "'#f5a9b8'";
        gradient_color_3 = "'#ffffff'";
        gradient_color_4 = "'#f5a9b8'";
        gradient_color_5 = "'#5bcefa'";
      };
    };
  };  

  # MPD
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music/music";
    network.startWhenNeeded = true;
    
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
        
      }
    '';
  };

  # RMPC
  programs.rmpc = {
    enable = true;
    #address: "127.0.0.1:6600",
    #address: "/run/user/1000/mpd/socket",
    config = ''
	#![enable(implicit_some)]
	#![enable(unwrap_newtypes)]
	#![enable(unwrap_variant_newtypes)]
	(
	    address: "/run/user/1000/mpd/socket",
	    password: None,
	    theme: "/home/amoeba/.dotfiles/hm-configs/musics/themes/NyAwAPurrfect",
	    cache_dir: Some("/tmp/rmpc/cache"),
            lyrics_dir: Some("~/Music/music"),
	    on_song_change: ["~/.dotfiles/hm-configs/musics/increment_play_count.sh"],
	    volume_step: 5,
	    max_fps: 30,
	    scrolloff: 0,
	    wrap_navigation: false,
	    enable_mouse: true,
	    status_update_interval_ms: 1000,
	    select_current_song_on_change: false,
	    browser_column_widths: [20, 38, 42],
	    album_art: (
		method: Auto,
		max_size_px: (width: 1200, height: 1200),
		disabled_protocols: ["http://", "https://"],
		vertical_align: Center,
		horizontal_align: Center,
	    ),
	    keybinds: (
		global: {
		    ":":       CommandMode,
		    ",":       VolumeDown,
		    "s":       Stop,
		    ".":       VolumeUp,
		    "<Tab>":   NextTab,
		    "<S-Tab>": PreviousTab,
		    "1":       SwitchToTab("Queue"),
		    "3":       SwitchToTab("Artists"),
		    "4":       SwitchToTab("Albums"),
		    "5":       SwitchToTab("Search"),
		    "6":       SwitchToTab("Playlists"),
		    "2":       SwitchToTab("Lyrics"),
		    "q":       Quit,
		    ">":       NextTrack,
		    "p":       TogglePause,
		    "<":       PreviousTrack,
		    "f":       SeekForward,
		    "z":       ToggleRepeat,
		    "x":       ToggleRandom,
		    "c":       ToggleConsume,
		    "v":       ToggleSingle,
		    "b":       SeekBack,
		    "~":       ShowHelp,
		    "I":       ShowCurrentSongInfo,
		    "O":       ShowOutputs,
		    "P":       ShowDecoders,
		},
		navigation: {
		    "k":         Up,
		    "j":         Down,
		    "h":         Left,
		    "l":         Right,
		    "<Up>":      Up,
		    "<Down>":    Down,
		    "<Left>":    Left,
		    "<Right>":   Right,
		    "<C-k>":     PaneUp,
		    "<C-j>":     PaneDown,
		    "<C-h>":     PaneLeft,
		    "<C-l>":     PaneRight,
		    "<C-u>":     UpHalf,
		    "N":         PreviousResult,
		    "a":         Add,
		    "A":         AddAll,
		    "r":         Rename,
		    "n":         NextResult,
		    "g":         Top,
		    "<Space>":   Select,
		    "<C-Space>": InvertSelection,
		    "G":         Bottom,
		    "<CR>":      Confirm,
		    "i":         FocusInput,
		    "J":         MoveDown,
		    "<C-d>":     DownHalf,
		    "/":         EnterSearch,
		    "<C-c>":     Close,
		    "<Esc>":     Close,
		    "K":         MoveUp,
		    "D":         Delete,
		},
		queue: {
		    "D":       DeleteAll,
		    "<CR>":    Play,
		    "<C-s>":   Save,
		    "a":       AddToPlaylist,
		    "d":       Delete,
		    "i":       ShowInfo,
		    "C":       JumpToCurrent,
		},
	    ),
	    search: (
		case_sensitive: false,
		mode: Contains,
		tags: [
		    (value: "any",         label: "Any Tag"),
		    (value: "artist",      label: "Artist"),
		    (value: "album",       label: "Album"),
		    (value: "albumartist", label: "Album Artist"),
		    (value: "title",       label: "Title"),
		    (value: "filename",    label: "Filename"),
		    (value: "genre",       label: "Genre"),
		],
	    ),
	    artists: (
		album_display_mode: NameOnly,
		album_sort_by: Name,
	    ),
	    tabs: [
			(
				name: "Queue",
				pane: Split(
					direction: Vertical,
					panes: [
						(
							size: "100%",
							borders: "NONE",
							pane: Split(
								borders: "NONE",
								direction: Horizontal,
								panes: [
									(
										size: "58%",
										borders: "ALL",
										pane: Pane(Queue),
									),
									(
										size: "42%",
										borders: "NONE",
										pane: Split(
											direction: Vertical,
											panes: [
												(
													size: "81%",
													borders: "ALL",
													pane: Pane(AlbumArt),
												),
												(
													size: "19%",
													borders: "NONE",
													pane: Pane(Lyrics),
												),
											]
										),
									),
								]
							),
						),
					],
				),
			),
			(
				name: "Lyrics",
				pane: Split(
					direction: Horizontal,
					panes: [(size: "45%", pane: Pane(AlbumArt)), (size: "55%", pane: Pane(Lyrics), horizonzal_align: Right)],
				),
			),
			(
				name: "Artists",
				pane: Split(
					direction: Horizontal,
					panes: [(size: "100%", borders: "ALL", pane: Pane(Artists))],
				),
			),
			(
				name: "Albums",
				pane: Split(
					direction: Horizontal,
					panes: [(size: "100%", borders: "ALL", pane: Pane(Albums))],
				),
			),
			(
				name: "Search",
				pane: Split(
					direction: Horizontal,
					panes: [(size: "100%", borders: "ALL", pane: Pane(Search))],
				),
			),
			(
				name: "Playlists",
				pane: Split(
					direction: Horizontal,
					panes: [(size: "100%", borders: "ALL", pane: Pane(Playlists))],
				),
			),
		],
        )
    '';
  };
}  
