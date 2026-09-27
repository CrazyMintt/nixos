{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    
    extraConfig = ''
    set nocompatible
    set linebreak
    filetype plugin on
    syntax on

    let mapleader = " "
    
    let g:vimwiki_list = [{ 'syntax': 'markdown', 'ext': 'md', 'path': '~/.Tenjin/'}]
    nnoremap <leader>ww :VimwikiIndex<CR>

    nnoremap <leader>vh :VimwikiGoto index<CR>
    nnoremap <leader>vm :VimwikiGoto Media/Media<CR>
    '';
  
    plugins = [
      pkgs.vimPlugins.vimwiki
    ];
  };
}