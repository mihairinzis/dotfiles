{ inputs, lib, config, pkgs, ... }: {
  imports = [];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-22.3.27"
  ];

  home = {
    username = "mihai";
    homeDirectory = "/home/mihai";
    sessionVariables = {
      EDITOR = "qemacs";
      TERMINAL = "kitty";
      BROWSER = "firefox";
    };
    sessionPath = [ "$HOME/.npm-global" ];
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    firefox
    chromium
    mpv
    stremio
    freetube
    rofi
    dunst
    lxqt.pavucontrol-qt
    pasystray
    cbatticon
    feh
    curl
    wget
    direnv
    yt-dlp
    killall
    btop
    redshift
    arandr
    autorandr
    zip
    unzip
    ripgrep
    filezilla
    flameshot
    fd
    fzf
    eza
    haskellPackages.greenclip
    emacs29-gtk3
    poppler
    playerctl
    (pkgs.nerdfonts.override { fonts = [ "Hack" "NerdFontsSymbolsOnly" "IosevkaTerm"]; })
    iosevka
    font-awesome
    appimage-run
    jq
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Mihai Rinzis";
    userEmail = "m.rinzis@gmail.com";
    delta.enable = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 1000000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [];
      # theme = "robbyrussell";
    };
    plugins = [{
      name = "zsh-autosuggestions";
      file = "./share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      src = pkgs.zsh-autosuggestions;
    }];
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break.disabled = true;
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
    git = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      proc_tree = true;
    };
  };

  programs.rofi = {
    enable = true;
    font = "Iosevka Light Expanded 12";
    # package = pkgs.rofi-wayland;
    extraConfig.icon-theme = "Papirus-Dark";
  };

  # programs.java = {
  #   enable = true;
  #   package = pkgs.jdk17;
  # };
  # home.file.".lib/jdk17".source = pkgs.jdk17;

  services.autorandr.enable = true;
  services.cbatticon.enable = true;

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        alignment = "center";
        corner_radius = 16;
        follow = "mouse";
        font = "Iosevka Light Expanded 12";
        format = "<b>%s</b>\\n%b";
        frame_width = 1;
        offset = "30x30";
        horizontal_padding = 8;
        icon_position = "left";
        indicate_hidden = "yes";
        markup = "yes";
        max_icon_size = 64;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        padding = 10;
        plain_text = "no";
        separator_color = "auto";
        separator_height = 1;
        show_indicators = false;
        shrink = "no";
        word_wrap = "yes";
      };

      fullscreen_delay_everything = {fullscreen = "delay";};

      urgency_critical = {
        background = "#3f3f3f";
        foreground = "#dcdccc";
        frame_color = "#DCDCCC";
      };
      urgency_low = {
        background = "#3f3f3f";
        foreground = "#dcdccc";
        frame_color = "#DCDCCC";
      };
      urgency_normal = {
        background = "#3f3f3f";
        foreground = "#9fafaf";
        frame_color = "#DCDCCC";
      };
    };
  };

  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    inactiveOpacity = 0.98;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = 0.3;
  };

  services.polybar= {
    enable = true;
    package = pkgs.polybarFull;
    script = "polybar mybar &";
  };

  programs.kitty = {
    enable = true;
    theme = "zenburned";
    font = {
      name = "IosevkaTerm NFM Light";
      size =  14;
    };
    settings = {
      copy_on_select = true;
      enabled_layouts = "*";
      scrollback_lines = 10000;
    };
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
