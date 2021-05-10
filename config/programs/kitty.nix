#
#  ██╗  ██╗██╗████████╗████████╗██╗   ██╗
#  ██║ ██╔╝██║╚══██╔══╝╚══██╔══╝╚██╗ ██╔╝
#  █████╔╝ ██║   ██║      ██║    ╚████╔╝
#  ██╔═██╗ ██║   ██║      ██║     ╚██╔╝
#  ██║  ██╗██║   ██║      ██║      ██║
#  ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝      ╚═╝
#   https://github.com/kovidgoyal/kitty

rec {
  configOptions = {
    extraConfig = ''
    '';
  };

  themeOptions = {
    cursor = "beam";

    font = {
      size = {
        size = "11.0";
        delta = "2";
      };

      family = "FiraCode Nerd Font Mono";
      bold = "auto";
      italic = "auto";
      bold_italic = "auto";
      features = "FiraCode-Regular +ss01 +ss03 +ss04 +ss05 +ss07 +ss08 +zero";
    };
  };
}
