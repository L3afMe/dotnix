#
# ██╗     ██╗ ██████╗ ██╗  ██╗████████╗
# ██║     ██║██╔════╝ ██║  ██║╚══██╔══╝
# ██║     ██║██║  ███╗███████║   ██║   
# ██║     ██║██║   ██║██╔══██║   ██║   
# ███████╗██║╚██████╔╝██║  ██║   ██║   
# ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
#     Default light theme based on
#            Rose Pina Dawn

rec {
  # Helper attributes, not actually needed to create a theme
  rps = {
    text    = "#575279";
    subtle  = "#6e6a86";
    ignored = "#9893a5";
    base    = "#F5E9DA";
    surface = "#FAF4ED";
    overlay = "#EDD7BD";
    love    = "#B4637A";
    sun     = "#EA9D34";
    rose    = "#D7827E";
    pine    = "#286983";
    foam    = "#56949F";
    iris    = "#907AA9";
  };

  # Main
  foreground = {
    # base7
    normal = "#575279";
    # base15
    bright = "#9893a5";
  };
  background = {
    # base0
    normal = "#F5E9DA";
    # base8
    bright = "#FAF4ED";
  };

  # Accents
  black = {
    normal = "#232136";
    bright = "#575279";
  };
  red = {
    # base1
    normal = "#B4637A";
    # base9
    bright = "#D7827E";
  };
  green = {
    # base2
    normal = "#569F84";
    # base10
    bright = "#9CD8C3";
  };
  yellow = {
    # base3
    normal = "#EA9D34";
    # base11
    bright = "#F6C177";
  };
  blue = {
    # base4
    normal = "#286983";
    # base12
    bright = "#CECAED";
  };
  magenta = {
    # base5
    normal = "#907AA9";
    # base13
    bright = "#C4A7E7";
  };
  cyan = {
    # base6
    normal = "#56959F";
    # base14
    bright = "#9CCFD8";
  };
  white = {
    normal = "#F2E9DE";
    bright = "#FAF4ED";
  };

  # Custom compontents
  viebColors = {
    suggestions = {
      border = rps.overlay;
      selected = rps.overlay;
    };
    notifications.border = rps.overlay;
  };

  nvimColors = {
    Comment.fg = rps.ignored;
    CursorLine.bg = rps.overlay;
    CursorLineNr.bg = rps.overlay;
    Pmenu.bg = rps.overlay;
    PmenuSel = {
      bg = rps.iris;
      fg = rps.overlay;
    };
    PmenuSbar.bg = rps.overlay;
    PmenuThumb.bg = rps.iris;
    VertSplit = {
      fg = white.normal;
    };
    StatusLine.bg = rps.overlay;
    StatusLineNC.bg = rps.overlay;
    Search.bg = rps.overlay;
    Visual.bg = rps.overlay;
    FoldColumn.bg = rps.overlay;
    Folded.bg = rps.overlay;
    IncSearch.bg = rps.overlay;
  };
}
