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

  ### Language Specific
  # CSS
  coc-css

  # Golang
  coc-go
  (import ./vim-go.nix { inherit pkgs; })

  # Java
  coc-java

  # JSON
  coc-json

  # LaTeX
  coc-vimtex
  vimtex

  # Lua
  vim-lua

  # Nix
  vim-nix

  # Markdown
  coc-markdownlint
  (import ./markdown-preview-nvim.nix { inherit pkgs; })
  tabular
  vim-markdown

  # Rust
  coc-rust-analyzer
  (import ./rust-vim.nix { inherit pkgs; })
  webapi-vim

  # Smali
  vim-smali

  # TOML
  vim-toml

  # YAML
  coc-yaml

  ### Search
  # Clear highlighting automatically
  vim-cool

  # Better * motions
  (import ./vim-asterisk.nix { inherit pkgs; })

  ### UI
  # Icons used in various plugins
  nvim-web-devicons

  # Better tab comp popup
  float-preview-nvim

  # Preview RGB colors
  nvim-colorizer-lua

  # Nicer start screen
  (import ./vim-startify.nix { inherit pkgs; })

  ## Treesitter - better syntax highlighting
  (import ./nvim-treesitter.nix { inherit pkgs luaConfig; })
  (import ./nvim-treesitter-playground.nix { inherit pkgs luaConfig; })

  ### File Editing
  # Automatically create pairs
  auto-pairs

  # Autosave
  (import ./vim-auto-save.nix { inherit pkgs; })

  ### Telescope
  (import ./telescope-nvim.nix { inherit pkgs luaConfig; })

  ### Git
  # Git signs in columb
  vim-signify

  # Diff view
  diffview-nvim

  ### Misc
  # More text objects
  targets-vim

  # Surrounding text objects
  vim-sandwich

  # System clipboard yank
  (import ./osc-yank.nix { inherit pkgs; })
]
