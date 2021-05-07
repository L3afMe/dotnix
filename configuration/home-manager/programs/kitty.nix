{ config, pkgs, ... }:
let
  conf = (import ../../../config { inherit pkgs; });
in
{
  config.home.file = with conf.programs.kitty; {
    kitty = with themeOptions; {
      target = ".config/kitty/kitty.conf";
      text = ''
        include nix-theme.conf

        font_family               ${font.family}
        bold_font                 ${font.bold}
        italic_font               ${font.italic}
        bold_italic_font          ${font.bold_italic}
        font_features             ${font.features}

        font_size                 ${font.size.size}
        font_size_delta           ${font.size.delta}

        cursor_shape              ${cursor}
        enable_audio_bell         no
        focus_follows_mouse       no
        scrollback_lines          10000
        scrollback_in_new_tab     no
        select_by_word_characters :@-./_~?&=%+#"'
        window_padding_width      ${conf.theme.padding}

        open_url_modifiers        ctrl+shift
        open_url_with             ${conf.user.programs.browser}

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
      '' + configOptions.extraConfig;
    };

    kitty-theme = with conf.theme.colors; {
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
    };
  };
}
