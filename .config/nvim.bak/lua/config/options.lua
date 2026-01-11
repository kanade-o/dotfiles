local opt = vim.opt

--opt.encoding = "utf-8"
--opt.fileencoding = "utf-8"

-- 行の表示
opt.number = true
opt.relativenumber = true

-- tab, indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.wrap = false

-- mouse deactivate
vim.opt.mouse = ""

-- share yank
opt.clipboard = "unnamedplus"

-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
