call plug#begin()
	Plug 'tpope/vim-surround'
	Plug 'preservim/nerdtree'
		nnoremap <C-n> :NERDTreeToggle<CR>
	Plug 'tpope/vim-commentary'
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
		let g:VM_maps = {}
		let g:VM_maps['Find Under'] = '<C-m>'
		let g:VM_maps['Find Subword Under'] = '<C-m>'
	Plug 'lervag/vimtex'
		let g:vimtex_compiler_latexmk = { 'build_dir' : 'build'}
	Plug 'SirVer/ultisnips'
		let g:UltiSnipsExpandTrigger		="<tab>"
		let g:UltiSnipsJumpForwardTrigger	="<tab>"
		let g:UltiSnipsJumpBackwardTrigger	="<s-tab>"
		let g:UltiSnipsEditSplit			="horizontal"
	Plug 'dense-analysis/ale'
	Plug 'nvie/vim-flake8'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
call plug#end()

augroup vim_settings
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4

	filetype plugin indent on

	set number relativenumber

	command! SnipEdit UltiSnipsEdit
augroup END

augroup latex_settings
    autocmd InsertLeave,TextChanged *.tex silent write

	let NERDTreeIgnore = [
				\'\.aux',
				\'\.fls',
				\'\.out',
				\'.synctex.gz',
				\'\.log',
				\'\.fdb_latexmk',
			\]
	
	let g:tex_flavor='latex'
	" let g:vimtex_view_method='zathura_simple'
	let g:vimtex_view_general_viewer='vimura'
	let g:vimtex_quickfix_mode=0
	set conceallevel=1
	let g:tex_conceal='abdmg'
augroup END

augroup python
	au BufNewFile, BufRead *.py
		\ syntax on
		\ set expandtab
		\ set autoindent
		\ set textwidth=79
		\ set fileformat=unix

	let g:ale_linters = {'python': ['flake8']}
augroup END

