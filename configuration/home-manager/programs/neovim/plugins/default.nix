{ pkgs, conf }:
with pkgs.vimPlugins;
let
  luaConfig = text: ''
    lua << EOF
    ${text}
    EOF
  '';
in
[
  ### LSP
  (import ./coc-nvim.nix { inherit pkgs; })

  fzf-vim

  ### Language Specific
  # CSS
  coc-css

  # Golang
  coc-go
  {
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

  # Java
  coc-java

  # JSON
  coc-json

  # LaTeX
  coc-vimtex
  vimtex

  # Lua
  pkgs.new-vim-shit.vimPlugins.vim-lua

  # Nix
  vim-nix

  # Markdown
  coc-markdownlint
  {
    plugin = pkgs.new-vim-shit.vimPlugins.markdown-preview-nvim;
    config = ''
      let g:mkdp_auto_start = 1
      let g:mkdp_browser = 'qutebrowser'
    '';
  }
  tabular
  vim-markdown

  # Rust
  coc-rust-analyzer
  {
    plugin = rust-vim;
    config = ''
      let g:rust_clip_command = 'xclip -selection clipboard'
    '';
  }
  webapi-vim

  # Smali
  pkgs.new-vim-shit.vimPlugins.vim-smali

  # TOML
  vim-toml

  # YAML
  coc-yaml

  ### Search
  # Clear highlighting automatically
  vim-cool

  # Better * motions
  {
    plugin = vim-asterisk;
    config = ''
      let g:asterisk#keeppos = 1

      map *   <Plug>(asterisk-*)
      map #   <Plug>(asterisk-#)
      map g*  <Plug>(asterisk-g*)
      map g#  <Plug>(asterisk-g#)
      map z*  <Plug>(asterisk-z*)
      map gz* <Plug>(asterisk-gz*)
      map z#  <Plug>(asterisk-z#)
      map gz# <Plug>(asterisk-gz#)
    '';
  }

  ### UI
  # Icons used in various plugins
  nvim-web-devicons

  # Better tab comp popup
  float-preview-nvim

  # Preview RGB colors
  nvim-colorizer-lua

  # Nicer start screen
  {
    plugin = vim-startify;
    config = ''
      function! s:gitModified()
        let files = systemlist('git ls-files -m 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
      endfunction

      function! s:gitUntracked()
        let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
      endfunction

      let g:startify_lists = [
        \   { 'type': 'files',     'header': ['   MRU']            },
        \   { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \   { 'type': 'sessions',  'header': ['   Sessions']       },
        \   { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \   { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \   { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \   { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
            
        let g:startify_change_to_dir = 0
        let g:startify_fortune_use_unicode = 1
    '';
  }

  ## Treesitter - better syntax highlighting
  {
    plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
    config = ''
      set foldlevel=99
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
    '' + luaConfig ''
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        query_linter = {
          enable = true,
        },
      }
    '';
  }

  {
    plugin = playground;
    config = luaConfig ''
      require "nvim-treesitter.configs".setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          keymaps = {
            open = "gt",
          },
        }
      }
    '';
  }

  ### File Editing
  # Automatically create pairs
  auto-pairs

  # Autosave
  {
    plugin = vim-auto-save;
    config = ''
      let g:auto_save = 1
    '';
  }

  ### Telescope
  popup-nvim
  plenary-nvim
  {
    plugin = telescope-nvim;
    config = ''
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
  }

  ### Git
  # Git signs in columb
  vim-signify

  # Diff view
  pkgs.new-vim-shit.vimPlugins.diffview-nvim

  ### Misc
  # More text objects
  targets-vim

  # Surrounding text objects
  vim-sandwich

  # System clipboard yank
  {
    plugin = vim-oscyank;
    config = ''
      vnoremap <leader>y :OSCYank<CR>
      autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
    '';
  }
]
