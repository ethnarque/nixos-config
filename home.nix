{
  config,
  pkgs,
  ...
}: let
  rose-pine = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "rose-pine";
    version = "0.1";
    rtpFilePath = "rose-pine.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "rose-pine";
      repo = "tmux";
      rev = "d588e25450762433790fc18be8f5197134c5b5cd";
      sha256 = "caP5qpVF11yAXxr4rt7zGGGUmguVEF4/cBpIxOdwDX4=";
    };
  };
in {
  home.username = "pmlogist";
  home.homeDirectory = "/Users/pmlogist";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.settings = {
    add_newline = false;
    #format = pkgs.lib.concatStrings [
    #  "$line_break"
    #  "$package"
    #  "$line_break"
    #  "$character"
    #];
  };

  programs.btop.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    defaultKeymap = "viins";
    autocd = true;
    dirHashes = {
      docs = "$HOME/Docs";
      dl = "$HOME/Downloads";
      music = "$HOME/Music";
      project = "$HOME/Code/pmlogist";
    };
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      save = 50000;
      size = 50000;
      ignoreDups = true;
    };
    envExtra = ''
      export PATH="/opt/homebrew/bin:$PATH"
    '';
    plugins = [
      rec {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = name;
          rev = "0.8.0-alpha1-pre-redrawhook";
          sha256 = "1gv7cl4kyqyjgyn3i6dx9jr5qsvr7dx1vckwv5xg97h81hg884rn";
        };
      }
      rec {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = name;
          rev = "0.32.0";
          sha256 = "12l9wrx0aysyj62kgp5limglz0nq73w8c415wcshxnxmhyk6sw6d";
        };
      }
      rec {
        name = "zsh-history-substring-search";
        file = "zsh-history-substring-search.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = name;
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-Space";
    # clock24 = true;
    # historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      better-mouse-mode
      rose-pine
    ];
    extraConfig = ''
      set -g mouse 'on'
      set -sg escape-time 0
      set-option -g status-position top

      set -g @rose_pine_variant dawn
      set -g @rose_pine_host on
      set -g @rose_pine_user 'on'
      set -g @rose_pine_window_tabs_enabled 'on'
      set -g @rose_pine_bar_bg_disabls 'on'
      set -g @rose_pine_only_windows 'on'
      set -g @rose_pine_left_separator ' > '
      set -g @rose_pine_right_separator ' < '
      set -g @rose_pine_field_separator ' | '

      set -g @rose_pine_session_icon ''
      set -g @rose_pine_current_window_icon ''
      set -g @rose_pine_folder_icon ''
      set -g @rose_pine_username_icon ''
      set -g @rose_pine_hostname_icon '󰒋'
      set -g @rose_pine_date_time_icon '󰃰'
      set -g @rose_pine_window_status_separator "  "

      set -g @rose_pine_prioritize_windows 'on'
      set -g @rose_pine_width_to_hide '80'
      set -g @rose_pine_window_count '5'
    '';
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.gh.enable = true;
  programs.gh.settings = {
    git_protocol = "ssh";
    prompt = "enabled";
  };
  programs.ssh.enable = true;

  programs.git.enable = true;
  programs.git.aliases = {
    forgor = "commit --amend --no-edit";
    graph = "log --all --decorate --graph --oneline";
    oops = "checkout --";
  };
  programs.git.extraConfig = {
    url = {
      "ssh://git@github.com" = {
        insteadOf = "https://github.com/";
      };
    };
  };
  programs.git.ignores = [
    "*~"
    "*.swp"
    "*result*"
    ".direnv"
    ".devenv"
    "node_modules"
  ];
  programs.git.userEmail = "42704376+pmlogist@users.noreply.github.com";
  programs.git.userName = "pmlogist";
}
