{ pkgs, conf, lib }:
{
  enable = true;

  config = {
    font_sharpener = "Harfbuzz";
    font_size = 10.0;

    front_end = "OpenGL";

    window_close_confirmation = "NeverPrompt";
    window_padding =
      let
        padding = toString conf.theme.padding;
      in
        "{ top = ${padding}, bottom = ${padding}, left = ${padding}, right = ${padding} }";
  };

  colors = with conf.theme; {
    background = colors.background.normal;
    foreground = colors.foreground.normal;
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

  extraConfig = ''
    font = wezterm.font("FiraCode Nerd Font Mono"),
  '';
}
