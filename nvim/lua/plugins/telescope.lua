return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended -- May not work on windows if make not installed
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
}
