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

  colors = conf.theme.weztermColors;

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
    let padding = toString conf.theme.padding;
    in ''
      window_padding = {
        top = ${padding},
        bottom = ${padding},
        left = ${padding},
        right = ${padding},
      },

      font = wezterm.font("FiraCode Nerd Font Mono"),
    '';
}
