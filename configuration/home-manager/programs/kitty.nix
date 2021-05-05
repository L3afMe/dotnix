{ config, pkgs, ... }:
let
  conf = import ../../../config { inherit pkgs; };
in
{
  config = {
    home.file.".config/kitty/kitty.conf".text = ''
include nix-theme.conf

font_family               ${conf.theme.kitty.font.family}
bold_font                 ${conf.theme.kitty.font.bold}
italic_font               ${conf.theme.kitty.font.italic}
bold_italic_font          ${conf.theme.kitty.font.bold_italic}
font_features             ${conf.theme.kitty.font.features}

font_size                 ${conf.theme.kitty.font.size.size}
font_size_delta           ${conf.theme.kitty.font.size.delta}

cursor_shape              ${conf.theme.kitty.cursor}
enable_audio_bell         no
focus_follows_mouse       no
scrollback_lines          10000
scrollback_in_new_tab     no
select_by_word_characters :@-./_~?&=%+#"'
window_padding_width      ${conf.theme.padding}

open_url_modifiers        ctrl+shift
open_url_with             ${conf.browser}

map ctrl+shift+v          paste_from_clipboard
map ctrl+shift+c          copy_to_clipboard

map ctrl+shift+k          scroll_line_up
map ctrl+shift+j          scroll_line_down

map ctrl+shift+enter      new_window
map ctrl+shift+w          close_window
map ctrl+shift+]          next_window
map ctrl+shift+[          previous_window

map ctrl+shift+l          next_tab
map ctrl+shift+h          previous_tab
map ctrl+shift+t          new_tab
map ctrl+shift+q          close_tab
map ctrl+shift+.          move_tab_forward
map ctrl+shift+,          move_tab_backward

map ctrl+shift+equal      increase_font_size
map ctrl+shift+minus      decrease_font_size
map ctrl+shift+backspace  restore_font_size

    '' + conf.kitty.extraConfig;

    home.file.".config/kitty/nix-theme.conf".text = ''
# Main colors
foreground              #${conf.theme.colors.foreground.normal}
background              #${conf.theme.colors.background.normal}
selection_foreground    #${conf.theme.colors.background.normal}
selection_background    #${conf.theme.colors.foreground.normal}
url_color               #${conf.theme.colors.red.normal}

# Cursor colors
cursor                  #${conf.theme.colors.foreground.normal}
cursor_text_color       #${conf.theme.colors.background.normal}

# Tab bar colors
active_tab_foreground   #${conf.theme.colors.background.normal}
active_tab_background   #${conf.theme.colors.foreground.normal}
inactive_tab_foreground #${conf.theme.colors.foreground.normal}
inactive_tab_background #${conf.theme.colors.background.normal}

# Black
color0  #${conf.theme.colors.black.normal}
color8  #${conf.theme.colors.black.bright}

# Red
color1  #${conf.theme.colors.red.normal}
color9  #${conf.theme.colors.red.bright}

# Yellow
color3  #${conf.theme.colors.yellow.normal}
color11 #${conf.theme.colors.yellow.bright}

# Magenta
color5  #${conf.theme.colors.magenta.normal}
color13 #${conf.theme.colors.magenta.bright}

# Blue
color4  #${conf.theme.colors.blue.normal}
color12 #${conf.theme.colors.blue.bright}

# Cyan
color6  #${conf.theme.colors.cyan.normal}
color14 #${conf.theme.colors.cyan.bright}

# Green
color2  #${conf.theme.colors.green.normal}
color10 #${conf.theme.colors.green.bright}

# White
color7  #${conf.theme.colors.white.normal}
color15 #${conf.theme.colors.white.bright}
     '';
  };
}
