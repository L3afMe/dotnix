#
#  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
# ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
# ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
# ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
# ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
#           User configuration options

{ pkgs, ... }:
rec {
  name = "l3af";
  email = "L3afMeAlone@gmail.com";
  homeDir = "/home/${name}";

  programs = {
    browser = "${pkgs.qutebrowser}";
    editor = "${pkgs.neovim-nightly}";
  };
}
