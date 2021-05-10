{ pkgs, conf, lib }:
let
  getBin = conf.helpers.getBin;
in
{
  enable = true;
  # Ensure that package matches one specified in config
  package = conf.user.programs.windowManager;

  wrapperFeatures.gtk = true;

  config = with conf.user.programs; {
    terminal = "${getBin terminal}";
    menu = "${getBin launcher}";

    window.border = conf.theme.borderWidth;
    floating.border = 10;
    gaps = {
      inner = conf.theme.gaps;
      outer = conf.theme.gaps;
      left = conf.theme.gaps;
      bottom = conf.theme.gaps;
      top = conf.theme.gaps;
      right = conf.theme.gaps;
    };

    colors = with conf.theme.swayColors; {
      background = background;

      focused = {
        border = window.focused.border;
        background = window.focused.background;
        childBorder = window.focused.childBorder;
        text = window.focused.text;
        indicator = window.focused.indicator;
      };
      focusedInactive = {
        border = window.focusedInactive.border;
        background = window.focusedInactive.background;
        childBorder = window.focusedInactive.childBorder;
        text = window.focusedInactive.text;
        indicator = window.focusedInactive.indicator;
      };
      unfocused = {
        border = window.unfocused.border;
        background = window.unfocused.background;
        childBorder = window.unfocused.childBorder;
        text = window.unfocused.text;
        indicator = window.unfocused.indicator;
      };
      urgent = {
        border = window.urgent.border;
        background = window.urgent.background;
        childBorder = window.urgent.childBorder;
        text = window.urgent.text;
        indicator = window.urgent.indicator;
      };
    };
  };

  extraConfig = ''
  '';
}
