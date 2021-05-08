#
# ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
# ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
#    ██║   ███████║█████╗  ██╔████╔██║█████╗
#    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
#    ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
#    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝
#       Global theming and visual options

{ pkgs, ... }:
let
  lib = pkgs.lib;
  elemAt = lib.elemAt;
in
rec {
  # Toggle light theme, can override "theme"
  # if you want to use a different theme
  lightTheme = true;
  theme =
    if lightTheme
    then import ./themes/theme-light.nix
    else import ./themes/theme-dark.nix;

  # Global theming values
  borderWidth = "2";
  cornerRadius = "0";
  padding = "15";

  ########################################
  # !   DO NOT MODIFY ANYTHING BELOW   ! #
  # !       Everything below can       ! #
  # !       be set in your theme       ! #
  ########################################

  colors = with theme; {
    foreground = {
      normal = foreground.normal or "#000000";
      bright = foreground.bright or "#555555";
    };
    background = {
      normal = background.normal or "#AAAAAA";
      bright = background.bright or "#FFFFFF";
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
    };
  } (theme.viebColors or {});

  nvimColors = lib.attrsets.recursiveUpdate {
    # Builtin
    Normal = {
      fg = (elemAt base16 7);
      bg = (elemAt base16 0);
    };
    Bold.gui = "BOLD";
    Debug.fg = (elemAt base16 8);
    Directory.fg = (elemAt base16 13);
    Error = {
      fg = (elemAt base16 8);
      bg = (elemAt base16 9);
    };
    ErrorMsg = {
      fg = (elemAt base16 0);
      bg = (elemAt base16 8);
    };
    Exception.fg = (elemAt base16 5);
    FoldColumn = {
      fg = (elemAt base16 12);
      bg = (elemAt base16 1);
    };
    Folded = {
      fg = (elemAt base16 3);
      bg = (elemAt base16 1);
    };
    IncSearch = {
      fg = (elemAt base16 1);
      bg = (elemAt base16 9);
    };
    Macro.fg = (elemAt base16 7);
    MatchParen.gui = "BOLD";
    ModeMsg.fg = (elemAt base16 11);
    MoreMsg.fg = (elemAt base16 11);
    Question.fg = (elemAt base16 13);
    Search = {
      bg = (elemAt base16 8);
      gui = "BOLD";
    };
    Substitute = {
      bg = (elemAt base16 8);
      gui = "BOLD";
    };
    SpecialKey.fg = (elemAt base16 9);
    TooLong.fg = (elemAt base16 8);
    Underlined.fg = (elemAt base16 8);
    Visual.bg = (elemAt base16 8);
    VisualNOS.bg = (elemAt base16 8);
    WarningMsg.fg = (elemAt base16 8);
    WildMenu = {
      fg = (elemAt base16 8);
      bg = (elemAt base16 10);
    };
    Title.fg = (elemAt base16 13);
    Conceal = {
      fg = (elemAt base16 13);
      bg = (elemAt base16 0);
    };
    Cursor = {
      fg = (elemAt base16 0);
      bg = (elemAt base16 7);
    };
    NonText.fg = (elemAt base16 3);
    LineNr.fg = (elemAt base16 15);
    StatusLine = {
      fg = (elemAt base16 7);
      bg = (elemAt base16 0);
    };
    StatusLineNC = {
      fg = (elemAt base16 7);
      bg = (elemAt base16 0);
    };
    ColorColumn.bg = (elemAt base16 8);
    CursorLine.bg = (elemAt base16 8);
    CursorLineNr = {
      fg = (elemAt base16 7);
      bg = (elemAt base16 8);
    };
    QuickFixLine.bg = (elemAt base16 1);
    Pmenu = {
      fg = (elemAt base16 7);
      bg = (elemAt base16 8);
    };
    PmenuSel = {
      fg = (elemAt base16 0);
      bg = colors.background.normal;
      gui = "BOLD";
    };
    PmenuSbar.bg = (elemAt base16 7);
    PmenuThumb.bg = (elemAt base16 8);
    TabLine = {
      fg = (elemAt base16 3);
      bg = (elemAt base16 1);
    };
    TabLineFill.fg = (elemAt base16 8);
    TabLineSel = { fg = (elemAt base16 8); gui = "BOLD"; };
    Boolean.fg = (elemAt base16 9);
    Character.fg = (elemAt base16 8);
    Comment.fg = (elemAt base16 3);
    Conditional.fg = (elemAt base16 6);
    Constant.fg = (elemAt base16 9);
    Define.fg = (elemAt base16 14);
    Delimiter.fg = (elemAt base16 15);
    Quote.fg = (elemAt base16 11);
    Float.fg = (elemAt base16 9);
    Function.fg = (elemAt base16 7);
    Identifier.fg = (elemAt base16 5);
    Include.fg = (elemAt base16 6);
    Number.fg = (elemAt base16 9);
    Operator.fg = (elemAt base16 5);
    PreProc.fg = (elemAt base16 5);
    Repeat.fg = (elemAt base16 10);
    Special.fg = (elemAt base16 4);
    SpecialChar.fg = (elemAt base16 9);
    Statement.fg = (elemAt base16 5);
    StorageClass.fg = (elemAt base16 10);
    String.fg = (elemAt base16 3);
    Integer.fg = (elemAt base16 9);
    Structure.fg = (elemAt base16 5);
    Tag.fg = (elemAt base16 10);
    Todo.fg = (elemAt base16 10);
    Type.fg = (elemAt base16 6);
    Typedef.fg = (elemAt base16 10);
    DiffAdd.fg = (elemAt base16 15);
    DiffChange.fg = (elemAt base16 3);
    DiffDelete.fg = (elemAt base16 9);
    Noise.fg = (elemAt base16 15);
    SignColumn = {};

    # Lua specific
    luaBraces.fg = (elemAt base16 15);
    luaFuncCall.fg = (elemAt base16 5);

    # Nix specific
    nixStringDelimiter.fg = (elemAt base16 3);
    nixNamespacedBuiltin.fg = (elemAt base16 5);
  } (theme.nvimColors or {});
}
