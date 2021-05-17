{ conf, lib }:
with conf.theme.colors; 
{
  target = ".config/kitty/nix-theme.conf";
  text = ''
    # Main colors
    foreground              ${foreground.normal}
    background              ${background.normal}
    selection_foreground    ${background.normal}
    selection_background    ${foreground.normal}
    url_color               ${red.normal}

    # Cursor colors
    cursor                  ${foreground.normal}
    cursor_text_color       ${background.normal}

    # Tab bar colors
    active_tab_foreground   ${background.normal}
    active_tab_background   ${foreground.normal}
    inactive_tab_foreground ${foreground.normal}
    inactive_tab_background ${background.normal}

    # Black
    color0  ${black.normal}
    color8  ${black.bright}

    # Red
    color1  ${red.normal}
    color9  ${red.bright}

    # Yellow
    color3  ${yellow.normal}
    color11 ${yellow.bright}

    # Magenta
    color5  ${magenta.normal}
    color13 ${magenta.bright}

    # Blue
    color4  ${blue.normal}
    color12 ${blue.bright}

    # Cyan
    color6  ${cyan.normal}
    color14 ${cyan.bright}

    # Green
    color2  ${green.normal}
    color10 ${green.bright}

    # White
    color7  ${white.normal}
    color15 ${white.bright}
  '';
}
