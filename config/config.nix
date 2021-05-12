#
#  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
# ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
# ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
# ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
# ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
#           User configuration options

{ pkgs }:
rec {
  ## Account information
  # Note: This can be overriden
  #   on a per-app basis inside
  #   config/programs/{program}

  # Used for user account, home directory 
  name = "l3af";
  homeDir = "/home/${name}";

  # Used for Git
  email = "L3afMeAlone@gmail.com";

  programs = {
    ## Configured Browsers
    # vieb
    # qutebrowser (TODO)
    browser = pkgs.vieb;

    ## Configured Editors
    # neovim-nightly
    # kakoune (TODO)
    # emacs   (TODO)
    editor = pkgs.neovim-nightly;

    ## Configured Terminals
    # kitty
    # wezterm
    # alacritty (TODO)
    # st        (TODO)
    terminal = pkgs.wezterm;

    # Configured Window Managers
    # X11
    #  i3-gaps    (TODO)
    #  bspwm      (TODO)
    #  herbstluft (TODO)
    # Wayland
    #  sway
    #  river   (TODO)
    windowManager = pkgs.sway;

    ## Configured Launchers
    # X11
    #  rofi (TODO)
    # Wayland
    #  wofi (TODO)
    launcher = {
      pkg = pkgs.wofi;
      args = [ "--show" "run" ];
    };

    ## Configured Shells
    # Bash
    # Zsh     (TODO)
    # Elvish  (TODO)
    # Hilbish (TODO)
    shell = pkgs.bash;
  };

  # Only set this if using an X11 window manager
  xserver = {
    enable = false;

    # Replace with window manager name
    defaultSession = "wm_name";
  };

  # Any extra packages you may want
  userPackages = with pkgs; [
  ];

  systemPackages = with pkgs; [
  ];
}
