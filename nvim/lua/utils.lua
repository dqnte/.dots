keymap = vim.api.nvim_set_keymap
nvim_cmd = vim.api.nvim_command
autocmd = vim.api.nvim_create_autocmd
buf_keymap = vim.api.nvim_buf_set_keymap
user_command = vim.api.nvim_create_user_command

lazy = function(config)
	table.insert(vim.lazy_config, config)
end

hi = function(group)
	nvim_cmd("hi " .. group)
end

local utils = {}

local fn = vim.fn
utils.get_color = function(group, attr)
	-- (Normal, "fg#")
	return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

local function clamp(component)
	return math.min(math.max(component, 0), 255)
end

utils.shift_color = function(col, amt)
	local num = tonumber(col, 16)
	local r = math.floor(num / 0x10000) + amt
	local g = (math.floor(num / 0x100) % 0x100) + amt
	local b = (num % 0x100) + amt
	local str = string.format("%#x", clamp(r) * 0x10000 + clamp(g) * 0x100 + clamp(b))
	return "#" .. str:gsub("0x", "")
end

utils.enable_colorscheme = function()
	vim.colorschemes[vim.env.THEME]()
end

utils.enable_lazy = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
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

    -- used to accumulate lazy config tables
    vim.lazy_config = {}
end

return utils
