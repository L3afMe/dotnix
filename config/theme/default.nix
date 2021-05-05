#
# ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
# ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
#    ██║   ███████║█████╗  ██╔████╔██║█████╗  
#    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝  
#    ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
#    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝
#          Theming and visual options

{ pkgs, ... }:
rec {
  lightTheme = true;
  borderWidth = "2";
  cornerRadius = "0";
  padding = "15";

  kitty = {
    cursor = "beam";

    font = {
      size = {
        size = "11.0";
        delta = "2";
      };

      family = "FiraCode Nerd Font Mono";
      bold = "auto";
      italic = "auto";
      bold_italic = "auto";
      features = "FiraCode-Regular +ss01 +ss03 +ss04 +ss05 +ss07 +ss08 +zero";
    };
  };

  neovim = {
    # Use "nix" to generate a colorscheme based off
    # of the colors defined at the end of this file
    # Themes can provide a custom colorscheme named
    # "vimColors" if you prefer more customization.
    colorscheme = "rose-pine-sepia";

    # Can be removed or commented out if using "nix"
    colorschemePkg = pkgs.vimUtils.buildVimPlugin {
      name = "rps-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "L3afMe";
        repo = "rose-pine-sepia-nvim";
        rev = "dc76c8c947322f256ca400c046a69dae435bfc21";
        sha256 = "1b40xbdh38ch2v1grx1plgnbv72jk1y7gjmza3iv2nbz4wxxgqmy";
      };
    };
  };

  colors = 
    if lightTheme
    then import ./theme-light.nix
    else import ./theme-dark.nix;

  base16 = [
    # Normal
    colors.background.normal
    colors.red.normal
    colors.green.normal
    colors.yellow.normal
    colors.blue.normal
    colors.magenta.normal
    colors.cyan.normal
    colors.foreground.normal

    # Bright
    colors.background.alt
    colors.red.bright
    colors.green.bright
    colors.yellow.bright
    colors.blue.bright
    colors.magenta.bright
    colors.cyan.bright
    colors.foreground.alt
  ];

  vimColors = {
  };
}
