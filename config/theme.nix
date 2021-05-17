#
# ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
# ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
#    ██║   ███████║█████╗  ██╔████╔██║█████╗
#    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
#    ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
#    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝
#       Global theming and visual options

{ pkgs }:
let
  lib = pkgs.lib;
  elemAt = lib.elemAt;
in
rec {
  # Switches background/foreground colors
  isLight = true;
  theme = import  ./themes/rose-pine-sepia.nix { inherit lib isLight; };

  # Global theming values
  borderWidth = 5;
  cornerRadius = 0;
  gaps = 15;
  padding = 30;

  ########################################
  # !   DO NOT MODIFY ANYTHING BELOW   ! #
  # !       Everything below can       ! #
  # !       be set in your theme       ! #
  ########################################

  colors = with theme; {
    foreground = {
      normal = foreground.normal or (if isLight then "#000000" else "#AAAAAA");
      bright = foreground.bright or (if isLight then "#555555" else "#FFFFFF");
    };
    background = {
      normal = background.normal or (if isLight then "#AAAAAA" else "#000000");
      bright = background.bright or (if isLight then "#FFFFFF" else "#555555");
    };
    black = {
      normal = black.normal or "#000000";
      bright = black.bright or "#555555";
    };
    red = {
      normal = red.normal or "#AA0000";
      bright = red.bright or "#FF5555";
    };
    green = {
      normal = green.normal or "#00AA00";
      bright = green.bright or "#55FF55";
    };
    yellow = {
      normal = yellow.normal or "#AAAA00";
      bright = yellow.bright or "#FFFF55";
    };
    magenta = {
      normal = magenta.normal or "#AA00AA";
      bright = magenta.bright or "#FF55FF";
    };
    blue = {
      normal = blue.normal or "#0000AA";
      bright = blue.bright or "#0000FF";
    };
    cyan = {
      normal = cyan.normal or "#00AAAA";
      bright = cyan.bright or "#00FFFF";
    };
    white = {
      normal = white.normal or "#AAAAAA";
      bright = white.bright or "#FFFFFF";
    };
  };

  ttyBase16 = with colors; [
    # Normal
    background.normal
    red.normal
    green.normal
    yellow.normal
    blue.normal
    magenta.normal
    cyan.normal
    foreground.normal

    # Bright
    background.bright
    red.bright
    green.bright
    yellow.bright
    blue.bright
    magenta.bright
    cyan.bright
    foreground.bright
  ];

  base16 = with colors; [
    # Normal
    black.normal
    red.normal
    green.normal
    yellow.normal
    blue.normal
    magenta.normal
    cyan.normal
    white.normal

    # Bright
    black.bright
    red.bright
    green.bright
    yellow.bright
    blue.bright
    magenta.bright
    cyan.bright
    white.bright
  ];

  # Can't use "with colors;" as it causes
  # infinite recursion when trying to
  # access colors.viebColors as it references
  # self.viebColors
  viebColors = lib.attrsets.recursiveUpdate {
    background = colors.background.normal;
    foreground = colors.foreground.normal;

    accent = colors.red.normal;

    tab = {
      splitAccent = viebColors.accent;
      background = {
        normal = colors.background.bright;
        selected = viebColors.background;
      };

      suspended = colors.red.bright;
      audio = colors.blue.normal;
      muted = colors.foreground.normal;
      muted-playing = colors.yellow.normal;
      crashed = colors.red.normal;
      scrollbar = colors.cyan.normal;
    };

    modes = {
      normal = {
        bg = "none";
        fg = colors.foreground.normal;
      };
      command = {
        bg = "none";
        fg = colors.red.normal;
      };
      insert = {
        bg = "none";
        fg = colors.green.normal;
      };
      follow = {
        bg = "none";
        fg = colors.magenta.normal;
      };
      explore = {
        bg = "none";
        fg = colors.cyan.normal;
      };
      search = {
        bg = "none";
        fg = colors.yellow.normal;
      };
      pointer = {
        bg = "none";
        fg = colors.foreground.normal;
      };
      visual = {
        bg = "none";
        fg = colors.blue.normal;
      };
    };

    suggestions = {
      bg = colors.background.normal;
      border = colors.foreground.normal;
      selected = colors.background.bright;
      url = colors.foreground.bright;
      file = colors.foreground.bright;
    };

    url = {
      default = colors.foreground.normal;
      search = colors.yellow.normal;
      searchwords = colors.magenta.normal;
      url = colors.cyan.normal;
      suggest = colors.green.normal;
      file = colors.yellow.normal;
      invalid = colors.red.normal;
      hover = {
        bg = colors.background.normal;
        fg = colors.foreground.normal;
      };
    };

    follow = {
      text = colors.foreground.normal;
      url = {
        bg = colors.cyan.bright;
        border = colors.cyan.normal;
      };
      click = {
        bg = colors.red.bright;
        border = colors.red.normal;
      };
      insert = {
        bg = colors.green.bright;
        border = colors.green.normal;
      };
      onclick = {
        bg = colors.yellow.bright;
        border = colors.yellow.normal;
      };
      other = {
        bg = colors.foreground.bright;
        border = colors.foreground.normal;
      };
    };

    notifications = {
      border = colors.foreground.normal;
      date = colors.foreground.bright;
      permission = colors.foreground.bright;
      error = colors.red.normal;
      warning = colors.yellow.normal;
      info = colors.foreground.normal;
      success = colors.green.normal;
    };
  } (theme.viebColors or {});

  nvimColors = with colors;
    lib.attrsets.recursiveUpdate {
      termColors = base16;

      # Builtin
      Normal = {
        fg = foreground.normal;
        ctermfg = "7";
        bg = background.normal;
        ctermbg = "0";
      };
      Bold.gui = "BOLD";
      Debug = { 
        fg = black.bright;
        ctermfg = "8";
      };
      Directory = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      Error = { 
        fg = red.normal;
        ctermfg = "1";
      };
      ErrorMsg = { 
        fg = red.normal;
        ctermfg = "1";
      };
      Exception = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      FoldColumn = {
        fg = foreground.normal;
        ctermfg = "7";
        bg = black.bright;
        ctermbg = "8";
      };
      Folded = {
        fg = foreground.normal;
        ctermfg = "7";
        bg = black.bright;
        ctermbg = "8";
      };
      IncSearch = {
        bg = black.bright;
        ctermbg = "8";
      };
      Macro = { 
        fg = foreground.normal;
        ctermfg = "7";
      };
      MatchParen.gui = "BOLD";
      ModeMsg = { 
        fg = yellow.bright;
        ctermfg = "11";
      };
      MoreMsg = { 
        fg = yellow.bright;
        ctermfg = "11";
      };
      Question = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      Search = {
        bg = black.bright;
        ctermbg = "8";
        gui = "BOLD";
      };
      Substitute = {
        bg = background.normal;
        ctermbg = "7";
        gui = "BOLD";
      };
      SpecialKey = { 
        fg = red.bright;
        ctermfg = "9";
      };
      TooLong = { 
        fg = foreground.normal;
        ctermfg = "7";
      };
      Underlined = { 
        fg = foreground.normal;
        ctermfg = "7";
      };
      Visual = { 
        bg = black.bright;
        ctermbg = "8";
      };
      VisualNOS.bg = black.bright;
      VisualNOS.ctermbg = "8";
      WarningMsg = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      WildMenu = {
        fg = black.bright;
        ctermfg = "8";
        bg = green.bright;
        ctermbg = "10";
      };
      Title = { 
        fg = magenta.bright;
        ctermfg = "13";
      };
      Conceal = {
        fg = magenta.bright;
        ctermfg = "13";
        bg = background.normal;
        ctermbg = "0";
      };
      Cursor = {
        fg = background.normal;
        ctermfg = "0";
        bg = background.normal;
        ctermbg = "7";
      };
      NonText = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      LineNr = { 
        fg = foreground.bright;
        ctermfg = "15";
      };
      StatusLine = {
        fg = foreground.normal;
        ctermfg = "7";
        bg = background.normal;
        ctermbg = "0";
      };
      StatusLineNC = {
        fg = foreground.normal;
        ctermfg = "7";
        bg = background.normal;
        ctermbg = "0";
      };
      ColorColumn = { 
        bg = black.bright;
        ctermbg = "8";
      };
      CursorLine = { 
        bg = black.bright;
        ctermbg = "8";
      };
      CursorLineNr = {
        fg = foreground.normal;
        ctermfg = "7";
        bg = black.bright;
        ctermbg = "8";
      };
      QuickFixLine = { 
        bg = red.normal;
        ctermbg = "1";
      };
      Pmenu = {
        fg = foreground.normal;
        ctermfg = "7";
        bg = black.bright;
        ctermbg = "8";
      };
      PmenuSel = {
        fg = background.normal;
        ctermfg = "0";
        bg = background.normal;
        ctermbg = "7";
        gui = "BOLD";
      };
      PmenuSbar = { 
        bg = background.normal;
        ctermbg = "7";
      };
      PmenuThumb = { 
        bg = black.bright;
        ctermbg = "8";
      };
      TabLine = {
        fg = yellow.normal;
        ctermfg = "3";
        bg = red.normal;
        ctermbg = "1";
      };
      TabLineFill = { 
        fg = black.bright;
        ctermfg = "8";
      };
      TabLineSel = { 
        fg = black.bright;
        ctermfg = "8";
        gui = "BOLD";
      };
      Boolean = { 
        fg = red.bright;
        ctermfg = "9";
      };
      Character = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      Comment = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      Conditional = { 
        fg = cyan.normal;
        ctermfg = "6";
      };
      Constant = { 
        fg = red.bright;
        ctermfg = "9";
      };
      Define = { 
        fg = cyan.bright;
        ctermfg = "14";
      };
      Delimiter = { 
        fg = foreground.bright;
        ctermfg = "15";
      };
      Quote = { 
        fg = yellow.bright;
        ctermfg = "11";
      };
      Float = { 
        fg = red.bright;
        ctermfg = "9";
      };
      Function = { 
        fg = foreground.normal;
        ctermfg = "7";
      };
      Identifier = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      Include = { 
        fg = cyan.normal;
        ctermfg = "6";
      };
      Number = { 
        fg = red.bright;
        ctermfg = "9";
      };
      Operator = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      PreProc = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      Repeat = { 
        fg = green.bright;
        ctermfg = "10";
      };
      Special = { 
        fg = blue.normal;
        ctermfg = "4";
      };
      SpecialChar = { 
        fg = red.bright;
        ctermfg = "9";
      };
      Statement = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      StorageClass = { 
        fg = green.bright;
        ctermfg = "10";
      };
      String = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      Integer = { 
        fg = red.bright;
        ctermfg = "9";
      };
      Structure = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      Tag = { 
        fg = green.bright;
        ctermfg = "10";
      };
      Todo = { 
        fg = green.normal;
        ctermfg = "2";
      };
      Type = { 
        fg = cyan.normal;
        ctermfg = "6";
      };
      Typedef = { 
        fg = green.bright;
        ctermfg = "10";
      };
      DiffAdd = { 
        fg = foreground.bright;
        ctermfg = "15";
      };
      DiffChange = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      DiffDelete = { 
        fg = red.bright;
        ctermfg = "9";
      };
      Noise = { 
        fg = foreground.bright;
        ctermfg = "15";
      };
      SignColumn = {};

      # Treesitter highlighting
      TSFunction = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      TSMethod = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      TSKeywordFunc = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      TSProperty = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      TSType = { 
        fg = cyan.normal;
        ctermfg = "6";
      };
      TSVariable = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
      TSPunctBracket = { 
        fg = foreground.bright;
        ctermfg = "15";
      };

      # Lua specific
      luaBraces = { 
        fg = foreground.bright;
        ctermfg = "15";
      };
      luaFuncCall = { 
        fg = foreground.normal;
        ctermfg = "7";
      };

      # Nix specific
      nixStringDelimiter = { 
        fg = yellow.normal;
        ctermfg = "3";
      };
      nixNamespacedBuiltin = { 
        fg = magenta.normal;
        ctermfg = "5";
      };
    } (theme.nvimColors or {});

  swayColors = lib.attrsets.recursiveUpdate {
    background = colors.background.bright;
    borders = colors.foreground.normal;

    window = {
      focused = {
        border = colors.foreground.normal;
        background = colors.background.normal;
        childBorder = colors.foreground.normal;
        text = colors.background.normal;
        indicator = colors.foreground.normal;
      };
      focusedInactive = {
        border = colors.background.normal;
        background = colors.foreground.bright;
        childBorder = colors.background.normal;
        text = colors.foreground.normal;
        indicator = colors.red.normal;
      };
      unfocused = {
        border = colors.background.normal;
        background = colors.foreground.bright;
        childBorder = colors.background.normal;
        text = colors.foreground.normal;
        indicator = colors.red.normal;
      };
      urgent = {
        border = colors.red.normal;
        background = colors.red.normal;
        childBorder = colors.red.normal;
        text = colors.foreground.normal;
        indicator = colors.red.normal;
      };
    };
  } (theme.swayColors or {});

  weztermColors = lib.attrsets.recursiveUpdate {
    # TODO: Bug
    #   This doesn't work and the background color
    #   has to be specified in the theme config
    background = colors.background.normal;
    foreground = colors.foreground.normal;

    cursor = {
      background = colors.foreground.normal;
      foreground = colors.background.normal;
      border = colors.foreground.normal;
    };

    selection = {
      background = colors.foreground.normal;
      foreground = colors.background.normal;
    };

    split = colors.foreground.normal;

    tabBar = {
      background = colors.background.normal;

      activeTab = {
        background = colors.foreground.normal;
        foreground = colors.background.normal;
        intensity = "Bold";
      };

      inactiveTab = {
        background = colors.foreground.bright;
        foreground = colors.background.normal;
        intensity = "Normal";
      };

      inactiveTabHover = {
        background = colors.foreground.bright;
        foreground = colors.background.normal;
        intensity = "Normal";
        italic = true;
      };
    };

    ansi = {
      black = colors.black.normal;
      red = colors.red.normal;
      green = colors.green.normal;
      yellow = colors.yellow.normal;
      blue = colors.blue.normal;
      magenta = colors.magenta.normal;
      cyan = colors.cyan.normal;
      white = colors.white.normal;
    };

    bright = {
      black = colors.black.bright;
      red = colors.red.bright;
      green = colors.green.bright;
      yellow = colors.yellow.bright;
      blue = colors.blue.bright;
      magenta = colors.magenta.bright;
      cyan = colors.cyan.bright;
      white = colors.white.bright;
    };
  } (theme.weztermColors or {});
}
