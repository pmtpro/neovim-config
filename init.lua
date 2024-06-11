local lazypath= vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            require('tokyonight').setup({
            })

            vim.cmd('colorscheme tokyonight')
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("ibl").setup()
        end
    },
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-autopairs",

    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    'junegunn/vim-easy-align',

    {
        'projekt0n/github-nvim-theme',
        -- lazy = false,
        -- priority = 1000,
        -- config = function()
        --     require('github-theme').setup({
        --     })

        --     vim.cmd('colorscheme github_dark')
        -- end,
    }

})



require("nvim-treesitter").setup()
require("nvim-autopairs").setup()
--



-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    window = {
    
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- File Explore
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = true
})

-- EasyAlign
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "Start EasyAlign (visual)" })
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { desc = "Start EasyAlign (motion/object)" })


--
-- setting

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.fileformats = { "unix", "dos", "mac" }

vim.opt.undofile = true
vim.opt.number = true
vim.opt.wrap = false

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.cursorline = true

-- vim.opt.clipboard = 'unnamedplus'
-- termux
-- install termux-api app and package

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = {
    tab = '▸ ',
    trail = '·',
    nbsp = '␣',
    extends = '❯',
    precedes = '❮',
}

-- ctrl + s
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a')

-- quick quit
vim.keymap.set('n', '<leader>q', ':q<CR>')

