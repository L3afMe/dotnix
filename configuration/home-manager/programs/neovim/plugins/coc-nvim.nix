{ pkgs }:
with pkgs.vimPlugins; {
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
    nmap <leader>f <Plug>(coc-format)
            
    nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
            
    " Add missing Go imports on save
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
  '';
}
