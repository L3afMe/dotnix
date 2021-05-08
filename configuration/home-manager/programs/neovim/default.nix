{ config, pkgs, lib, ... }:
let
  conf = import ../../../../config { inherit pkgs; };
in
{
  config = with conf.programs.neovim; {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly.overrideAttrs (old: { patches = import ./patches; });

      withNodeJs = true;

      viAlias = true;
      vimAlias = true;

      plugins = (import ./plugins { inherit pkgs conf; })
      ++ configOptions.extraPlugins ++ (
        if lib.hasAttrByPath [ "colorschemePkg" ] themeOptions
        then [ themeOptions.colorschemePkg ]
        else []
      );

      extraPackages = with pkgs; [ rnix-lsp ];

      extraConfig = ''
        """""""""""""""""""
        "  Auto Commands  "
        """""""""""""""""""
        augroup hide_inactive_cursorline
          autocmd!
          autocmd WinEnter,BufEnter * setlocal cursorline
          autocmd WinLeave,BufLeave * setlocal nocursorline
        augroup END

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
          autocmd Colorscheme * highlight YankColor ctermfg=59 ctermbg=41 guifg=#34495E guibg=#2ECC71
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
        " Set leader to space
        nnoremap <SPACE> <Nop>
        let mapleader=" "

        " Make ; and : open cmd
        nnoremap ; :
        xnoremap ; :

        nnoremap <leader>l :foldopen<CR>
        nnoremap <leader>h :foldclose<CR>
        
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

        """""""""""""
        "  Options  "
        """""""""""""
        "" General
        set termguicolors
        colorscheme ${themeOptions.colorscheme}
        
        set splitbelow splitright
        
        set timeoutlen=300
        set updatetime=300
        
        set cmdheight=1
        
        set noswapfile
        
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
         
        set number relativenumber
        
        set fileencoding=utf-8
        
        set linebreak
        set showbreak=↪
        
        set wildmode=list:longest
        
        set cursorline
        set nocursorcolumn
        
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
        """ Nix
        augroup nix
          autocmd!

          autocmd FileType nix setlocal expandtab tabstop=2 shiftwidth=2
        augroup END

        """ LaTeX
        let g:tex_flavor='latex'

        augroup tex
          autocmd!
        
          autocmd FileType tex setlocal expandtab tabstop=2 shiftwidth=2
        augroup END
        
        """ JavaScript
        augroup js
          autocmd!
        
          autocmd FileType js setlocal noexpandtab tabstop=2 shiftwidth=2
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
      '' + configOptions.extraConfig;
    };

    home.file = {
      coc-settings =
        let
          json = pkgs.formats.json {};
          output = json.generate "coc-settings.json" configOptions.cocConfig;
        in
          {
            target = ".config/nvim/coc-settings.json";
            source = output;
          };

      nixTheme = lib.mkIf (conf.programs.neovim.themeOptions.colorscheme == "nix")
        {
          target = ".config/nvim/colors/nix.vim";
          text = with conf.theme;
            let
              colorNames = builtins.attrNames nvimColors;
              makeHi = group:
                "hi ${group} " + "guifg=${(nvimColors.${group}.fg or "NONE")} " + "guibg=${(nvimColors.${group}.bg or "NONE")} " + "gui=${(nvimColors.${group}.gui or "NONE")}";
              highlights = builtins.map makeHi colorNames;
              generatedColorscheme = builtins.concatStringsSep "\n" highlights;
            in
              ''
                " File generated by L3af's Nix config
                " modify in config/theme.nix

                if version > 580
                  hi clear
                  if exists("syntax_on")
                    syntax reset
                  endif
                endif

                let g:colors_name = "nix"

                ${generatedColorscheme}
              '';
        };

      # Treesitter scm's
    };
  };
}
