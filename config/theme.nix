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
  lightTheme = true;
  theme = import  ./themes/theme-light.nix;

  # Global theming values
  borderWidth = 5;
  cornerRadius = 0;
  gaps = 15;
  padding = 15;

  ########################################
  # !   DO NOT MODIFY ANYTHING BELOW   ! #
  # !       Everything below can       ! #
  # !       be set in your theme       ! #
  ########################################

  colors = with theme; {
    foreground = {
      normal =
        if lightTheme
        then black.normal or "#000000"
        else white.normal or "#AAAAAA";
      bright = 
        if lightTheme
        then black.bright or "#555555"
        else white.bright or "#FFFFFF";
    };
    background = {
      normal = 
        if lightTheme
        then white.normal or "#AAAAAA"
        else black.normal or "#000000";
      bright = 
        if lightTheme
        then white.bright or "#FFFFFF"
        else black.bright or "#555555";
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

  base16 = with colors; [
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

  nvimColors =
    lib.attrsets.recursiveUpdate {
      termColors = base16;
      # Builtin
      Normal = {
        fg = (elemAt base16 7);
        ctermfg = "7";
        bg = (elemAt base16 0);
        ctermbg = "0";
      };
      Bold.gui = "BOLD";
      Debug = { 
        fg = (elemAt base16 8);
        ctermfg = "8";
      };
      Directory = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      Error = { 
        fg = (elemAt base16 1);
        ctermfg = "1";
      };
      ErrorMsg = { 
        fg = (elemAt base16 1);
        ctermfg = "1";
      };
      Exception = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      FoldColumn = {
        fg = (elemAt base16 7);
        ctermfg = "7";
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      Folded = {
        fg = (elemAt base16 7);
        ctermfg = "7";
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      IncSearch = {
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      Macro = { 
        fg = (elemAt base16 7);
        ctermfg = "7";
      };
      MatchParen.gui = "BOLD";
      ModeMsg = { 
        fg = (elemAt base16 11);
        ctermfg = "11";
      };
      MoreMsg = { 
        fg = (elemAt base16 11);
        ctermfg = "11";
      };
      Question = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      Search = {
        bg = (elemAt base16 8);
        ctermbg = "8";
        gui = "BOLD";
      };
      Substitute = {
        bg = (elemAt base16 7);
        ctermbg = "7";
        gui = "BOLD";
      };
      SpecialKey = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      TooLong = { 
        fg = (elemAt base16 7);
        ctermfg = "7";
      };
      Underlined = { 
        fg = (elemAt base16 7);
        ctermfg = "7";
      };
      Visual = { 
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      VisualNOS.bg = (elemAt base16 8);
      VisualNOS.ctermbg = "8";
      WarningMsg = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      WildMenu = {
        fg = (elemAt base16 8);
        ctermfg = "8";
        bg = (elemAt base16 10);
        ctermbg = "10";
      };
      Title = { 
        fg = (elemAt base16 13);
        ctermfg = "13";
      };
      Conceal = {
        fg = (elemAt base16 13);
        ctermfg = "13";
        bg = (elemAt base16 0);
        ctermbg = "0";
      };
      Cursor = {
        fg = (elemAt base16 0);
        ctermfg = "0";
        bg = (elemAt base16 7);
        ctermbg = "7";
      };
      NonText = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      LineNr = { 
        fg = (elemAt base16 15);
        ctermfg = "15";
      };
      StatusLine = {
        fg = (elemAt base16 7);
        ctermfg = "7";
        bg = (elemAt base16 0);
        ctermbg = "0";
      };
      StatusLineNC = {
        fg = (elemAt base16 7);
        ctermfg = "7";
        bg = (elemAt base16 0);
        ctermbg = "0";
      };
      ColorColumn = { 
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      CursorLine = { 
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      CursorLineNr = {
        fg = (elemAt base16 7);
        ctermfg = "7";
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      QuickFixLine = { 
        bg = (elemAt base16 1);
        ctermbg = "1";
      };
      Pmenu = {
        fg = (elemAt base16 7);
        ctermfg = "7";
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      PmenuSel = {
        fg = (elemAt base16 0);
        ctermfg = "0";
        bg = (elemAt base16 7);
        ctermbg = "7";
        gui = "BOLD";
      };
      PmenuSbar = { 
        bg = (elemAt base16 7);
        ctermbg = "7";
      };
      PmenuThumb = { 
        bg = (elemAt base16 8);
        ctermbg = "8";
      };
      TabLine = {
        fg = (elemAt base16 3);
        ctermfg = "3";
        bg = (elemAt base16 1);
        ctermbg = "1";
      };
      TabLineFill = { 
        fg = (elemAt base16 8);
        ctermfg = "8";
      };
      TabLineSel = { 
        fg = (elemAt base16 8);
        ctermfg = "8";
        gui = "BOLD";
      };
      Boolean = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      Character = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      Comment = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      Conditional = { 
        fg = (elemAt base16 6);
        ctermfg = "6";
      };
      Constant = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      Define = { 
        fg = (elemAt base16 14);
        ctermfg = "14";
      };
      Delimiter = { 
        fg = (elemAt base16 15);
        ctermfg = "15";
      };
      Quote = { 
        fg = (elemAt base16 11);
        ctermfg = "11";
      };
      Float = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      Function = { 
        fg = (elemAt base16 7);
        ctermfg = "7";
      };
      Identifier = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      Include = { 
        fg = (elemAt base16 6);
        ctermfg = "6";
      };
      Number = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      Operator = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      PreProc = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      Repeat = { 
        fg = (elemAt base16 10);
        ctermfg = "10";
      };
      Special = { 
        fg = (elemAt base16 4);
        ctermfg = "4";
      };
      SpecialChar = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      Statement = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      StorageClass = { 
        fg = (elemAt base16 10);
        ctermfg = "10";
      };
      String = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      Integer = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      Structure = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      Tag = { 
        fg = (elemAt base16 10);
        ctermfg = "10";
      };
      Todo = { 
        fg = (elemAt base16 2);
        ctermfg = "2";
      };
      Type = { 
        fg = (elemAt base16 6);
        ctermfg = "6";
      };
      Typedef = { 
        fg = (elemAt base16 10);
        ctermfg = "10";
      };
      DiffAdd = { 
        fg = (elemAt base16 15);
        ctermfg = "15";
      };
      DiffChange = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      DiffDelete = { 
        fg = (elemAt base16 9);
        ctermfg = "9";
      };
      Noise = { 
        fg = (elemAt base16 15);
        ctermfg = "15";
      };
      SignColumn = {};

      # Treesitter highlighting
      TSFunction = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      TSMethod = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      TSKeywordFunc = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      TSProperty = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      TSType = { 
        fg = (elemAt base16 6);
        ctermfg = "6";
      };
      TSVariable = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
      TSPunctBracket = { 
        fg = (elemAt base16 15);
        ctermfg = "15";
      };

      # Lua specific
      luaBraces = { 
        fg = (elemAt base16 15);
        ctermfg = "15";
      };
      luaFuncCall = { 
        fg = (elemAt base16 7);
        ctermfg = "7";
      };

      # Nix specific
      nixStringDelimiter = { 
        fg = (elemAt base16 3);
        ctermfg = "3";
      };
      nixNamespacedBuiltin = { 
        fg = (elemAt base16 5);
        ctermfg = "5";
      };
    } (theme.nvimColors or {});

  swayColors = lib.attrsets.recursiveUpdate {
    background = colors.background.normal;
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
}
