{ pkgs, conf, lib }:
{
  enable = true;

  settings = {
    font_sharper = "Harfbuzz";
    font_size = 10.0;

    front_end = "OpenGL";

    window_close_confirmation = "NeverPrompt";

    hide_tab_bar_if_only_one_tab = true;
  };

  colors = with conf.theme; {
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
  };

  keybindings = [
    {
      modifiers = [ "CTRL" "SHIFT" ];
      key = "L";
      action = "wezterm.action { ActivateTabRelative = 1 }";
    }
    {
      modifiers = [ "CTRL" "SHIFT" ];
      key = "H";
      action = "wezterm.action { ActivateTabRelative = -1 }";
    }
  ];

  extraReturnSettings = 
    let
        padding = toString conf.theme.padding;
    in
    ''
      window_padding = {
        top = ${padding},
        bottom = ${padding},
        left = ${padding},
        right = ${padding},
      },

      font = wezterm.font("FiraCode Nerd Font Mono"),
    '';
}
