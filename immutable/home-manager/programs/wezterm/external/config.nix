{ conf, lib }:
with conf.theme;
let
  padding = toString conf.theme.padding;
in
{
  target = ".config/wezterm/wezterm.lua";
  text = ''
    wezterm = require("wezterm")

    return {
      colors = {
        foreground = "${colors.foreground.normal}",
        background = "${colors.background.normal}",
      };

      keys = {
        {
          mods = "CTRL|SHIFT",
          key = "L",
          action = wezterm.action { ActivateTabRelative = 1 }
        },
        {
          mods = "CTRL|SHIFT",
          key = "H",
          action = wezterm.action { ActivateTabRelative = -1 }
        },
      },

      window_close_confirmation = "NeverPrompt",
      window_padding = { top = ${padding}, bottom = ${padding}, left = ${padding}, right = ${padding} },
    }
  '';
}
