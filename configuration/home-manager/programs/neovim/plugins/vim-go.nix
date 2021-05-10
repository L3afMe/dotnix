{ pkgs }:
with pkgs.vimPlugins; {
    plugin = vim-go;
    config = ''
      let g:go_fmt_command = "goimports"
      let g:go_autodetect_gopath = 1
      let g:go_list_type = "quickfix"

      let g:go_highlight_types = 1
      let g:go_highlight_fields = 1
      let g:go_highlight_functions = 1
      let g:go_highlight_function_calls = 1
      let g:go_highlight_extra_types = 1
      let g:go_highlight_generate_tags = 1
    '';
  }
