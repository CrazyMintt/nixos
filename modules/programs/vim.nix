{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    
    extraConfig = ''
    set nocompatible
    filetype plugin on
    syntax on

    let mapleader = " "
    
    let g:vimwiki_list = [{ 'syntax': 'markdown', 'ext': 'md'}]
    nnoremap <leader>ww :VimwikiIndex<CR>
    '';
  
    plugins = [
      pkgs.vimPlugins.vimwiki
    ];
  };
}