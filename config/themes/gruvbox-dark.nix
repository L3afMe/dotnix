#
# ██╗     ██╗ ██████╗ ██╗  ██╗████████╗
# ██║     ██║██╔════╝ ██║  ██║╚══██╔══╝
# ██║     ██║██║  ███╗███████║   ██║   
# ██║     ██║██║   ██║██╔══██║   ██║   
# ███████╗██║╚██████╔╝██║  ██║   ██║   
# ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
#         Light theme based on
#            Rose Pina Dawn

rec {
  # Helper attributes, not actually needed to create a theme
  gb = {
    dark0_hard  = "#1d2021";
    dark0       = "#282828";
    dark0_soft  = "#32302f";
    dark1       = "#3c3836";
    dark2       = "#504945";
    dark3       = "#665c54";
    dark4       = "#7c6f64";
    dark4_256   = "#7c6f64";

    gray_245    = "#928374";
    gray_244    = "#928374";

    light0_hard = "#f9f5d7";
    light0      = "#fbf1c7";
    light0_soft = "#f2e5bc";
    light1      = "#ebdbb2";
    light2      = "#d5c4a1";
    light3      = "#bdae93";
    light4      = "#a89984";
    light4_256  = "#a89984";

    accent = {
      bright = {
        red     = "#fb4934";
        green   = "#b8bb26";
        yellow  = "#fabd2f";
        blue    = "#83a598";
        purple  = "#d3869b";
        aqua    = "#8ec07c";
        orange  = "#fe8019";
      };

      neutral = {
        red    = "#cc241d";
        green  = "#98971a";
        yellow = "#d79921";
        blue   = "#458588";
        purple = "#b16286";
        aqua   = "#689d6a";
        orange = "#d65d0e";
      };

      faded = {
        red      = "#9d0006";
        green    = "#79740e";
        yellow   = "#b57614";
        blue     = "#076678";
        purple   = "#8f3f71";
        aqua     = "#427b58";
        orange   = "#af3a03";
      };
    };
  };

  # Main colors
  black = {
    normal = gb.dark0;
    bright = gb.dark2;
  };
  red = {
    # base1
    normal = gb.accent.neutral.red;
    # base9
    bright = gb.accent.bright.red;
  };
  green = {
    # base2
    normal = gb.accent.neutral.green;
    # base10
    bright = gb.accent.bright.green;
  };
  yellow = {
    # base3
    normal = gb.accent.neutral.yellow;
    # base11
    bright = gb.accent.bright.yellow;
  };
  blue = {
    # base4
    normal = gb.accent.neutral.blue;
    # base12
    bright = gb.accent.bright.blue;
  };
  magenta = {
    # base5
    normal = gb.accent.neutral.purple;
    # base13
    bright = gb.accent.bright.purple;
  };
  cyan = {
    # base6
    normal = gb.accent.neutral.aqua;
    # base14
    bright = gb.accent.bright.aqua;
  };
  white = {
    normal = gb.light2;
    bright = gb.light0;
  };

  # Custom compontents
# viebColors = {
#   suggestions = {
#     border = rps.overlay;
#     selected = rps.overlay;
#   };
#   notifications.border = rps.overlay;
# };
#
# nvimColors = {
#   Comment.fg = rps.ignored;
#   CursorLine.bg = rps.overlay;
#   CursorLineNr.bg = rps.overlay;
#   Pmenu.bg = rps.overlay;
#   PmenuSel = {
#     bg = rps.iris;
#     fg = rps.overlay;
#   };
#   PmenuSbar.bg = rps.overlay;
#   PmenuThumb.bg = rps.iris;
#   VertSplit = {
#     fg = white.normal;
#   };
#   StatusLine.bg = rps.overlay;
#   StatusLineNC.bg = rps.overlay;
#   Search.bg = rps.overlay;
#   Visual.bg = rps.overlay;
#   FoldColumn.bg = rps.overlay;
#   Folded.bg = rps.overlay;
#   IncSearch.bg = rps.overlay;
# };
}
