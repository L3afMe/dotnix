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
    gaps = with conf.theme; {
      inner = gaps;
      outer = gaps;
      left = gaps;
      bottom = gaps;
      top = gaps;
      right = gaps;
    };

    # Set everything the same for all outputs
    output."*" = {
      bg = ''${conf.theme.swayColors.background} solid_color'';
    };

    # Disable the default bar
    bars = [];

    startup = [
      {
        command = ''pkill waybar; waybar'';
        always = true;
      }
    ];

    colors = with conf.theme.swayColors; {
      background = background;

      inherit (window) focused focusedInactive unfocused urgent;
    };
  };
}
