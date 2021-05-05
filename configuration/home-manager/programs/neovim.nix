{ config, pkgs, lib, ... }:
let
  vim-lua = pkgs.vimUtils.buildVimPlugin {
    name = "vim-lua";
    src = pkgs.fetchFromGitHub {
      owner = "tbastos";
      repo = "vim-lua";
      rev = "fa810f85437525bcea0fc4ff22c634935721d86d";
      sha256 = "1fkpfjpmv80lcd7jn95pzxrcbzn8avdywjknd5bn3212ahydg43m";
    };
  };
  vim-smali = pkgs.vimUtils.buildVimPlugin {
    name = "vim-smali";
    src = pkgs.fetchFromGitHub {
      owner = "mzlogin";
      repo = "vim-smali";
      rev = "012c21565e6be8f1718ad634aa84730a0a84b42c";
      sha256 = "1mcdbcfiq5r21q297fxi18c3ah4193j1fnjnbjnrjh20r50wggx8";
    };
  };
  markdown-preview-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "markdown-preview-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "iamcco";
      repo = "markdown-preview.nvim";
      rev = "e5bfe9b89dc9c2fbd24ed0f0596c85fd0568b143";
      sha256 = "0bfkcfjqg2jqm4ss16ks1mfnlnpyg1l4l18g7pagw1dfka14y8fg";
    };
  };
  rps-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "rps-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "L3afMe";
      repo = "rose-pine-sepia-nvim";
      rev = "dc76c8c947322f256ca400c046a69dae435bfc21";
      sha256 = "1b40xbdh38ch2v1grx1plgnbv72jk1y7gjmza3iv2nbz4wxxgqmy";
    };
  };

in
{
  config = {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;

      withNodeJs = true;

      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        ### Autocomplete
        { 
          plugin = coc-nvim;
          config = ''
            inoremap <silent><expr> <TAB>
                  \ pumvisible() ? "\<C-n>" :
                  \ <SID>check_back_space() ? "\<TAB>" :
                  \ coc#refresh()
            inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
            
            function! s:check_back_space() abort
              let col = col('.') - 1
              return !col || getline('.')[col - 1]  =~# '\s'
            endfunction
            
            inoremap <silent><expr> <c-space> coc#refresh()
            
            inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
            
            nmap <silent> [g <Plug>(coc-diagnostic-prev)
            nmap <silent> ]g <Plug>(coc-diagnostic-next)
            
            nmap <silent> gd <Plug>(coc-definition)
            nmap <silent> gy <Plug>(coc-type-definition)
            nmap <silent> gi <Plug>(coc-implementation)
            nmap <silent> gr <Plug>(coc-references)
            
            autocmd CursorHold * silent call CocActionAsync('highlight')
            
            nmap <leader>rn <Plug>(coc-rename)
            
            xmap <leader>f <Plug>(coc-format-selected)
            nmap <leader>f <Plug>(coc-format-selected)
            
            nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
            nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
            nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
            nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
            
            " Add missing Go imports on save
            autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
          '';
        }
        
        ### Language Specific
        # Golang
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

        # LaTeX
        vimtex

        # Lua
        vim-lua

        # Nix
        vim-nix

        # Markdown
        {
          plugin = markdown-preview-nvim;
            config = ''
              let g:mkdp_auto_start = 1
              let g:mkdp_browser = 'qutebrowser'
            '';
        }
        tabular
        vim-markdown
        
        # Rust
        {
          plugin = rust-vim;
            config = ''
              let g:rust_clip_command = 'xclip -selection clipboard'
            '';
        }
        webapi-vim

        # Smali
        vim-smali

        # TOML
        vim-toml

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
        # Themes
        {
          plugin = rps-nvim;
            config = ''
              colorscheme rose-pine-sepia
            '';
        }

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

        # Better syntax highlighting
        {
          plugin = nvim-treesitter;
            config = ''
              nnoremap <leader>ff <cmd>Telescope find_files<cr>
              nnoremap <leader>fg <cmd>Telescope live_grep<cr>
              nnoremap <leader>fb <cmd>Telescope buffers<cr>
              nnoremap <leader>fh <cmd>Telescope help_tags<cr>
            '';
        }

        ### File Editing
        # Automatically create pairs
        auto-pairs

        # Snippets
        {
          plugin = ultisnips;
            config = ''
              let g:UltiSnipsExpandTrigger="<c-j>"
              let g:UltiSnipsJumpForwardTrigger="<c-b>"
              let g:UltiSnipsJumpBackwardTrigger="<c-z>"
              let g:UltiSnipsEditSplit="vertical"
            '';
        }

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
        telescope-nvim

        ### Git
        vim-signify

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
      ];

      extraPackages = with pkgs; [ rnix-lsp ];

      extraConfig = ''
        """""""""""""""""""
        "  Auto Commands  "
        """""""""""""""""""
        augroup dynamic_smartcase
        autocmd!
          autocmd CmdLineEnter : set nosmartcase
          autocmd CmdLineLeave : set smartcase
        augroup END

        augroup term_settings
          autocmd!
          autocmd TermOpen * setlocal norelativenumber nonumber
          autocmd TermOpen * startinsert
        augroup END
        
        augroup resume_edit_position
          autocmd!
          autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
        augroup END
        
        augroup non_utf8_file_warn
          autocmd!
          autocmd BufRead * if &fileencoding != 'utf-8' | unsilent echomsg 'File not in UTF-8 format!' | endif
        augroup END
        
        augroup auto_read
          autocmd!
          autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
                \ if mode() == 'n' && getcmdwintype() == "" | checktime | endif
          autocmd FileChangedShellPost * echohl WarningMsg
                \ | echo "File changed on disk. Buffer reloaded!" | echohl None
        augroup END
        
        augroup numbertoggle
          autocmd!
          autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
          autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
        augroup END
        
        augroup custom_highlight
          autocmd!
          autocmd ColorScheme * highlight YankColor ctermfg=59 ctermbg=41 guifg=#34495E guibg=#2ECC71
        augroup END
        
        augroup highlight_yank
          autocmd!
          au TextYankPost * silent! lua vim.highlight.on_yank{higroup="YankColor", timeout=300}
        augroup END
        
        function! s:empty_message(timer)
          if mode() ==# 'n'
            echo ""
          endif
        endfunction
        
        augroup cmd_msg_cls
            autocmd!
            autocmd CursorHold * call timer_start(25000, funcref('s:empty_message'))
        augroup END
        
        augroup auto_save_folds
          autocmd!
          autocmd BufWinLeave * silent mkview
          autocmd BufWinEnter * silent loadview
        augroup END

        """""""""""""
        "  Mapping  "
        """""""""""""
        " Make ; and : open cmd
        nnoremap ; :
        xnoremap ; :
        
        nnoremap <silent> <leader>Q :<C-U>qa<CR>
        
        " Create new line below/above without insert
        nnoremap <expr> oo printf('m`%so<ESC>``', v:count1)
        nnoremap <expr> OO printf('m`%sO<ESC>``', v:count1)

        " Better j/k movement
        nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
        nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
        
        nnoremap <Tab> %

        " H/L to move to start/end of line
        nnoremap H ^
        xnoremap H ^
        nnoremap L g_
        xnoremap L g_
        
        " Easy indention
        xnoremap < <gv
        xnoremap > >gv
        
        " Easy replace
        nnoremap <C-H> :%s/
        xnoremap <C-H> :s/
        
        " Shift-indent
        inoremap <S-Tab> <ESC><<i
        
        " Copy whole buffer
        nnoremap <silent> <leader>Y :<C-U>%y<CR>

        " Show syntax highlight groups
        map gm :call ShowSyn()<CR>
        map gme :call ShowSynEnable()<CR>
        map gmd :call ShowSynDisable()<CR>

        """""""""""""""""""""""""""""""
        "  Highlight Group Functions  "
        """""""""""""""""""""""""""""""
        let s:showSynEnabled=0
        function! s:ShowSyn(auto)
            if a:auto == 0 || s:showSynEnabled == 1
                for i1 in synstack(line("."), col("."))
                    let i2 = synIDtrans(i1)
                    let n1 = synIDattr(i1, "name")
                    let n2 = synIDattr(i2, "name")
                    echo n1 "->" n2
                endfor
            endif
        endfunction
        
        function! ShowSynEnable()
            let s:showSynEnabled = 1
            call s:ShowSyn(1)
        endfunction
        
        function! ShowSynDisable()
            let s:showSynEnabled = 0
        endfunction
        
        function! ShowSyn()
            call s:ShowSyn(0)
        endfunction

        """""""""""""
        "  Options  "
        """""""""""""
        "" General
        set termguicolors
        
        set splitbelow splitright
        
        set timeoutlen=300
        set updatetime=300
        
        set cmdheight=1
        
        set noswapfile
        
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
        
        set foldlevelstart=0
        set foldmethod=expr
        set foldexpr=VimFolds(v:lnum)
        set foldtext=VimFoldText()
        
        set number relativenumber
        
        set fileencoding=utf-8
        
        set linebreak
        set showbreak=↪
        
        set wildmode=list:longest
        
        set cursorline
        
        set scrolloff=5
        
        set mouse=nic
        set mousemodel=popup
        
        set noshowmode
        
        set fileformats=unix
        
        set inccommand=nosplit
        
        set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
        set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
        set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
        set wildignore+=*.pyc
        set wildignore+=*.DS_Store
        set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz
        set wildignorecase
        
        set confirm
        
        set visualbell noerrorbells
        
        set history=500
        
        set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+
        
        set autowrite
        
        set undofile
        
        set pumheight=10
        
        set shiftround
        
        set virtualedit=block
        
        set formatoptions+=mM
        
        set nojoinspaces
        
        set synmaxcol=200
        set nostartofline
        
        set signcolumn=auto:2
        
        set isfname-==
        set isfname-=,

        "" Language Specific
        """ LaTeX
        let g:tex_flavor='latex'

        augroup tex
          autocmd!
        
          autocmd BufNewFile,BufRead *.tex setlocal expandtab tabstop=2 shiftwidth=2
        augroup END
        
        """ JavaScript
        augroup js
          autocmd!
        
          autocmd BufNewFile,BufRead *.js setlocal noexpandtab tabstop=2 shiftwidth=2
          autocmd FileType js nmap <leader>f CocCommand prettier.formatFile<CR>
        augroup END
        
        """ Golang
        augroup go
          autocmd!
        
          autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
        
          autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
          autocmd FileType go nmap <leader>t <Plug>(go-test)
          autocmd FileType go nmap <leader>r <Plug>(go-run)
          autocmd FileType go nmap <Leader>d <Plug>(go-def)
          autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
          autocmd FileType go nmap <Leader>i <Plug>(go-info)
          autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
          autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
          autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
        
          autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
          autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
          autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
          autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
        augroup END
      '';
    };

    home.file.coc-settings = {
      target = ".config/nvim/coc-settings.vim";
      text = ''
        {
          "go.goplsOptions": {
            "codelenses": {
              "gc_details": true
            },
            "analyses": {
              "shadow": true,
              "unusedparams": true,
              "unusedresult": true,
              "loopclosure": true,
              "testinggoroutine": true,
              "bools": true,
              "tests": true,
              "assign": true,
              "shift": true,
              "sortslice": true,
              "nonewvars": true
            },
            "hoverKind": "Structured"
          },
          "Lua.intelliSense.searchDepth": 4,
          "rust-analyzer.cargo.allFeatures": true,
          "rust-analyzer.procMacro.enable": true,
          "rust-analyzer.lens.methodReferences": true,
          "rust-analyzer.checkOnSave.command": "clippy",
          "smali.enable": true
        }
      '';
    };
  };
}
