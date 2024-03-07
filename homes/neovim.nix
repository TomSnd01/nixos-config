{ pkgs, ...}: 

{
  programs.neovim = {
    enable = true;
    #plugins = with pkgs.vimPlugins; [
		#	base46
		#	nvchad-ui
		#	telescope-nvim
		#	nvim-tree-lua
		#	nvim-cmp
		#	nvim-lspconfig
		#	luasnip
		#	cmp-nvim-lsp
		#	friendly-snippets
		#	cmp_luasnip
		#	(nvim-treesitter.withPlugins (p: [
		#		p.tree-sitter-nix
		#		p.tree-sitter-vim
		#		p.tree-sitter-bash
		#		p.tree-sitter-lua
		#		p.tree-sitter-json
		#		p.tree-sitter-toml
		#		p.tree-sitter-yaml
		#		p.tree-sitter-rust
		#		p.tree-sitter-javascript
		#		p.tree-sitter-typescript
		#		p.tree-sitter-tsx
		#		p.tree-sitter-python
		#		p.tree-sitter-slint
		#		p.tree-sitter-html
		#		p.tree-sitter-css
		#	]))
   # ];
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      
      vim.o.clipboard = 'unnamedplus'

      vim.o.relativenumber = true

      vim.o.signcolumn = 'yes'
      
      vim.o.tabstop = 2
      vim.o.shiftwidth = 2

      vim.o.updatetime = 300

      vim.o.termguicolors = true

      vim.o.mouse = 'a'
			
    '';
  };
}
