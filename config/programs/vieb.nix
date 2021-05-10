#
#   ██╗   ██╗██╗███████╗██████╗ 
#   ██║   ██║██║██╔════╝██╔══██╗
#   ██║   ██║██║█████╗  ██████╔╝
#   ╚██╗ ██╔╝██║██╔══╝  ██╔══██╗
#    ╚████╔╝ ██║███████╗██████╔╝
#     ╚═══╝  ╚═╝╚══════╝╚═════╝
# https://github.com/Jelmerro/Vieb

{ pkgs, ... }:
let
  user = import ../config.nix { inherit pkgs; };
  getBin = (import ../config.nix { lib = pkgs.lib; }).getBin;
in 
rec {
  configOptions = {
    caseInsensitive = true;
    editorCommand = getBin user.programs.editor;
    # Mouse support needed for scrolling
    # even though it's keyboard mapping
    mouseSupport = true;
    restoreTabs = true;
    search = "https://duckduckgo.com/?q=%s";

    extraConfig = ''
    '';
  };

  themeOptions = {
    # Valid colorschemes:
    # nix         - Generated from theme with customizations
    # nix-default - Generated from theme, only touches colors
    # default     - Default dark
    # light       - Default light
    # flipped     - Bar at the bottom
    colorscheme = "nix-default";
  };
}
