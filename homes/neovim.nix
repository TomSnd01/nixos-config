{ pkgs, ...}: 

{
  programs.neovim = {
    enable = true;
		defaultEditor = true;
    plugins = with pkgs.vimPlugins; [

    ];
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      
      vim.o.clipboard = 'unnamedplus'

      vim.o.relativenumber = true

      vim.o.signcolumn = 'yes'
      
      vim.o.tabstop = 2
      vim.o.shiftwidth = 2

      vim.o.updatetime = 300

      vim.o.mouse = 'a'
			
    '';
  };
}
