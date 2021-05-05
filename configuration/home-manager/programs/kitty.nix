{ config, pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [ kitty ];

    home.file.".config/kitty/kitty.conf".text = ''
include rose-pine-dawn.conf

font_family       FiraCode Nerd Font Mono 
italic_font       auto
bold_font         auto
bold_italic_font  auto
font_features     FiraCode-Regular +ss01 +ss03 +ss04 +ss05 +ss07 +ss08 +zero

font_size        11.0
font_size_delta  2

cursor_shape              beam
enable_audio_bell         no
focus_follows_mouse       no
scrollback_lines          10000
scrollback_in_new_tab     no
select_by_word_characters :@-./_~?&=%+#"'
window_padding_width 15

open_url_modifiers ctrl+shift
open_url_with      default

map ctrl+shift+v paste_from_clipboard
map ctrl+shift+c copy_to_clipboard

map ctrl+shift+k    scroll_line_up
map ctrl+shift+j    scroll_line_down

map ctrl+shift+enter new_window
map ctrl+shift+w     close_window
map ctrl+shift+]     next_window
map ctrl+shift+[     previous_window

map ctrl+shift+l next_tab
map ctrl+shift+h previous_tab
map ctrl+shift+t new_tab
map ctrl+shift+q close_tab
map ctrl+shift+. move_tab_forward
map ctrl+shift+, move_tab_backward

map ctrl+shift+equal     increase_font_size
map ctrl+shift+minus     decrease_font_size
map ctrl+shift+backspace restore_font_size
    '';

    home.file.".config/kitty/rose-pine-dawn.conf".text = ''
# Main colors
foreground              #575279
background              #F5E9DA
selection_foreground    #F5E9DA
selection_background    #575279
url_color               #F5E9DA

# Cursor colors
cursor                  #232136
cursor_text_color       #F5E9DA

# Tab bar colors
active_tab_foreground   #F5E9DA
active_tab_background   #575279
inactive_tab_foreground #575279
inactive_tab_background #F5E9DA

# Black
color0  #232136
color8  #575279

# Red
color1  #B4637A
color9  #D7827E

# Yellow
color3  #EA9D34
color11 #F6C177

# Magenta
color5  #907AA9
color13 #C4A7E7

# Blue
color4  #286983
color12 #CECAED

# Cyan
color6  #56959F
color14 #9CCFD8

# Green
color2  #569F84
color10 #9CD8C3

# White
color7  #F2E9DE
color15 #FAF4ED
     '';
  };
}
