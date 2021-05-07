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
  user = (import ../config.nix { inherit pkgs; });
in 
rec {
  configOptions = {
    search = "https://duckduckgo.com/?q=%s";
    mouseSupport = false;
    restoreTabs = true;
    caseInsensitive = true;
    editorCommand = user.programs.editor;

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
