{ pkgs, conf, lib }:
with conf.programs.kitty;
{
  enable = true;

  settings = with theme.themeOptions; {
    allow_remote_control = true;

    font_family = font.family;
    bold_font = font.bold;
    italic_font = font.italic;
    bold_italic_font = font.bold_italic;
    font_features = font.features;

    font_size = font.size.size;
    font_size_delta = font.size.delta;

    cursor_shape = cursor;
    enable_audio_bell = false;
    focus_follows_mouse = false;
    scrollback_lines = 10000;
    scrollback_in_new_tab = false;
    select_by_word_characters = ":@-./_~?&=%+#\"'";
    window_padding_width = toString conf.theme.padding;

    open_url_modifiers = "ctrl+shift";
    open_url_with = getBin conf.user.programs.browser;
  };

  keybindings = {
    "ctrl+shift+v" = "paste_from_clipboard";
    "ctrl+shift+c" = "copy_to_clipboard";

    "ctrl+shift+k" = "scroll_line_up";
    "ctrl+shift+j" = "scroll_line_down";

    "ctrl+shift+enter" = "new_window";
    "ctrl+shift+w" = "close_window";
    "ctrl+shift+]" = "next_window";
    "ctrl+shift+[" = "previous_window";

    "ctrl+shift+l" = "next_tab";
    "ctrl+shift+h" = "previous_tab";
    "ctrl+shift+t" = "new_tab";
    "ctrl+shift+q" = "close_tab";
    "ctrl+shift+." = "move_tab_forward";
    "ctrl+shift+," = "move_tab_backward";

    "ctrl+shift+equal" = "increase_font_size";
    "ctrl+shift+minus" = "decrease_font_size";
    "ctrl+shift+backspace" = "restore_font_size";
  };

  extraConfig = ''
    include nix-theme.conf
  '' + configOptions.extraConfig;
}
