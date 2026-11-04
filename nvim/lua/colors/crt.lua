-- crt: red phosphor on a black tube, dark only.
-- same typographic rules as eink, with steps of one red instead of grays,
-- and nerv orange for what should catch the eye first (definitions,
-- headings, matches, the cursor, the mode chip)

local palettes = {
	dark = {
		bg = "#0a0202", -- tube black with a red cast
		float = "#140404", -- panels glow slightly
		wash = "#330d0a",
		line = "#5c1813", -- hairline borders
		faint = "#6e211b",
		mid = "#9e3a32",
		ink = "#d0483d", -- the deep red claude draws auto mode in
		accent = "#f28a1e", -- nerv/magi terminal orange
	},
}

-- eink's gray chips go muddy in red, so the mode chip is lit phosphor
-- with black text, and the bands behind it stay close to the tube
local function lualine_theme(p)
	local b = { fg = p.ink, bg = p.wash }
	local c = { fg = p.mid, bg = p.float }
	local chip = function(gui)
		return { a = { fg = p.bg, bg = p.accent, gui = gui }, b = b, c = c }
	end
	return {
		normal = chip("bold"),
		insert = chip("bold,italic"),
		visual = chip("bold"),
		replace = chip("bold,strikethrough"),
		command = chip("italic"),
		inactive = { a = c, b = c, c = c },
	}
end

vim.colorschemes.crt = function()
	require("colors/eink").apply("crt", palettes, lualine_theme)
end
