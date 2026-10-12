-- e-ink: attention is carried by typography, not hue.
--   plain   -> most code
--   gray    -> noise (punctuation, imports, comments)
--   italic  -> strings, comments, builtins
--   bold    -> definitions, control-flow exits, errors
--   reverse -> things that demand action (current match, TODO, selection)
--   underline family -> diagnostics (curl = error, dotted = warn, dashed = info/hint)

local palettes = {
	light = {
		bg = "#f2f2f2", -- cool gray page
		float = "#fafafa", -- panels sit whiter than the page
		wash = "#e3e3e3",
		line = "#cccccc", -- hairline borders
		faint = "#a6a6a6",
		mid = "#777777",
		ink = "#333333", -- charcoal, not black
	},
	dark = {
		bg = "#141414",
		float = "#1f1f1f",
		wash = "#2b2b2b",
		line = "#3b3b3b",
		faint = "#5a5a5a",
		mid = "#8c8c8c",
		ink = "#d9d9d9",
	},
}

-- same stepped shape as iceberg, mid chip into a line band into a wash band,
-- with modes told apart by weight and style instead of hue
local function lualine_theme(p)
	local b = { fg = p.ink, bg = p.line }
	local c = { fg = p.mid, bg = p.wash }
	local chip = function(gui)
		return { a = { fg = p.float, bg = p.mid, gui = gui }, b = b, c = c }
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

local function groups(p)
	local reverse = { fg = p.bg, bg = p.ink, bold = true }

	return {
		-- editor ui
		Normal = { fg = p.ink, bg = p.bg },
		NormalNC = { link = "Normal" },
		NormalFloat = { fg = p.ink, bg = p.float },
		FloatBorder = { fg = p.line, bg = p.float },
		FloatTitle = { fg = p.ink, bg = p.float, bold = true },
		Cursor = { fg = p.bg, bg = p.ink },
		CursorLine = { bg = p.float },
		CursorColumn = { bg = p.float },
		ColorColumn = { bg = p.float },
		CursorLineNr = { fg = p.ink, bold = true },
		LineNr = { fg = p.faint },
		SignColumn = {},
		FoldColumn = { fg = p.faint },
		Folded = { fg = p.mid, bg = p.float, italic = true },
		WinSeparator = { fg = p.line },
		VertSplit = { link = "WinSeparator" },
		StatusLine = { fg = p.ink, bg = p.wash },
		StatusLineNC = { fg = p.mid, bg = p.float },
		WinBar = { fg = p.ink, bold = true },
		WinBarNC = { fg = p.mid },
		TabLine = { fg = p.mid, bg = p.float },
		TabLineSel = { fg = p.ink, bg = p.bg, bold = true },
		TabLineFill = { bg = p.float },
		NonText = { fg = p.faint },
		EndOfBuffer = { fg = p.wash },
		Whitespace = { fg = p.wash },
		SpecialKey = { fg = p.faint },
		Conceal = { fg = p.faint },
		Directory = { fg = p.ink, bold = true },
		Title = { fg = p.ink, bold = true },
		MatchParen = { bold = true, underline = true },
		QuickFixLine = { bg = p.wash, bold = true },

		-- selection and search
		Visual = { bg = p.wash },
		VisualNOS = { link = "Visual" },
		Search = { bg = p.wash, underline = true },
		CurSearch = reverse,
		IncSearch = reverse,
		Substitute = reverse,

		-- popup menu
		Pmenu = { fg = p.ink, bg = p.float },
		PmenuSel = { fg = p.ink, bg = p.wash, bold = true },
		PmenuSbar = { bg = p.float },
		PmenuThumb = { bg = p.faint },
		PmenuKind = { fg = p.mid, bg = p.float },
		PmenuExtra = { fg = p.faint, bg = p.float, italic = true },
		PmenuMatch = { fg = p.ink, bg = p.float, bold = true, underline = true },
		PmenuMatchSel = { fg = p.ink, bg = p.wash, bold = true, underline = true },
		WildMenu = { link = "PmenuSel" },

		-- messages
		ErrorMsg = reverse,
		WarningMsg = { fg = p.ink, bold = true },
		ModeMsg = { fg = p.ink, bold = true },
		MoreMsg = { fg = p.ink, bold = true },
		Question = { fg = p.ink, bold = true },
		MsgArea = { fg = p.ink },

		-- spelling
		SpellBad = { undercurl = true, sp = p.mid },
		SpellCap = { underdotted = true, sp = p.mid },
		SpellLocal = { underdashed = true, sp = p.faint },
		SpellRare = { underdashed = true, sp = p.faint },

		-- syntax
		Comment = { fg = p.mid, italic = true },
		String = { fg = p.ink, italic = true },
		Character = { link = "String" },
		Constant = { fg = p.ink },
		Identifier = { fg = p.ink },
		Function = { fg = p.ink },
		Statement = { fg = p.ink },
		Keyword = { fg = p.ink },
		Operator = { fg = p.ink },
		PreProc = { fg = p.mid },
		Include = { fg = p.mid },
		Type = { fg = p.ink },
		Special = { fg = p.ink },
		Delimiter = { fg = p.mid },
		Underlined = { underline = true },
		Ignore = { fg = p.faint },
		Error = { fg = p.ink, undercurl = true, sp = p.ink },
		Todo = reverse,

		-- treesitter: definitions are bold, uses are plain
		["@function"] = { bold = true },
		["@function.method"] = { bold = true },
		["@function.call"] = { fg = p.ink },
		["@function.method.call"] = { fg = p.ink },
		["@function.builtin"] = { italic = true },
		["@constructor"] = { fg = p.ink },
		["@type.definition"] = { bold = true },
		["@type.builtin"] = { italic = true },
		["@variable.builtin"] = { italic = true },
		["@constant.builtin"] = { italic = true },
		["@module"] = { fg = p.ink },
		["@keyword.import"] = { fg = p.mid },
		["@keyword.return"] = { bold = true },
		["@keyword.exception"] = { bold = true },
		["@punctuation"] = { fg = p.mid },
		["@punctuation.delimiter"] = { fg = p.mid },
		["@punctuation.bracket"] = { fg = p.mid },
		["@punctuation.special"] = { fg = p.mid },
		["@string.escape"] = { fg = p.mid, italic = true },
		["@string.special.url"] = { underline = true },
		["@tag"] = { fg = p.ink },
		["@tag.attribute"] = { fg = p.mid },
		["@tag.delimiter"] = { fg = p.faint },
		["@comment.todo"] = reverse,
		["@comment.error"] = reverse,
		["@comment.warning"] = { fg = p.ink, bold = true, underline = true },
		["@comment.note"] = { fg = p.ink, bold = true },

		-- markup
		["@markup.heading"] = { fg = p.ink, bold = true },
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.link"] = { underline = true },
		["@markup.link.url"] = { fg = p.mid, underline = true },
		["@markup.raw"] = { bg = p.float },
		["@markup.quote"] = { fg = p.mid, italic = true },
		["@markup.list"] = { fg = p.mid },

		-- lsp semantic tokens: leave calls plain, bold declarations
		["@lsp.type.function"] = {},
		["@lsp.type.method"] = {},
		["@lsp.typemod.function.declaration"] = { bold = true },
		["@lsp.typemod.method.declaration"] = { bold = true },
		["@lsp.typemod.class.declaration"] = { bold = true },
		["@lsp.typemod.type.declaration"] = { bold = true },
		["@lsp.typemod.interface.declaration"] = { bold = true },
		["@lsp.typemod.enum.declaration"] = { bold = true },
		["@lsp.mod.deprecated"] = { strikethrough = true },
		LspReferenceText = { bg = p.wash },
		LspReferenceRead = { bg = p.wash },
		LspReferenceWrite = { bg = p.wash, underline = true },
		LspInlayHint = { fg = p.faint, italic = true },
		LspSignatureActiveParameter = { bold = true, underline = true },

		-- diagnostics
		DiagnosticError = { fg = p.ink, bold = true },
		DiagnosticWarn = { fg = p.ink },
		DiagnosticInfo = { fg = p.mid },
		DiagnosticHint = { fg = p.mid, italic = true },
		DiagnosticOk = { fg = p.mid },
		DiagnosticUnderlineError = { undercurl = true, sp = p.ink },
		DiagnosticUnderlineWarn = { underdotted = true, sp = p.ink },
		DiagnosticUnderlineInfo = { underdashed = true, sp = p.mid },
		DiagnosticUnderlineHint = { underdashed = true, sp = p.faint },
		DiagnosticUnderlineOk = { underdashed = true, sp = p.faint },
		DiagnosticVirtualTextError = { fg = p.ink, italic = true, bold = true },
		DiagnosticVirtualTextWarn = { fg = p.ink, italic = true },
		DiagnosticVirtualTextInfo = { fg = p.mid, italic = true },
		DiagnosticVirtualTextHint = { fg = p.faint, italic = true },
		DiagnosticSignError = { fg = p.ink, bold = true },
		DiagnosticSignWarn = { fg = p.ink },
		DiagnosticSignInfo = { fg = p.mid },
		DiagnosticSignHint = { fg = p.faint },
		DiagnosticDeprecated = { strikethrough = true },
		DiagnosticUnnecessary = { fg = p.faint },

		-- diff mode
		DiffAdd = { bg = p.float, bold = true },
		DiffChange = { bg = p.float },
		DiffText = { bg = p.wash, bold = true, underline = true },
		DiffDelete = { fg = p.faint, bg = p.float },

		-- diff filetype (fugitive, git commit)
		Added = { fg = p.ink, bold = true },
		Changed = { fg = p.ink, italic = true },
		Removed = { fg = p.mid, strikethrough = true },
		["@diff.plus"] = { link = "Added" },
		["@diff.delta"] = { link = "Changed" },
		["@diff.minus"] = { link = "Removed" },
		diffAdded = { link = "Added" },
		diffChanged = { link = "Changed" },
		diffRemoved = { link = "Removed" },
		diffFile = { fg = p.ink, bold = true },
		diffLine = { fg = p.mid },
		diffSubname = { fg = p.mid },

		-- gitsigns: new lines are ink, edits are gray
		GitSignsAdd = { fg = p.ink },
		GitSignsChange = { fg = p.faint },
		GitSignsDelete = { fg = p.ink },
		GitSignsUntracked = { fg = p.faint },
		GitSignsCurrentLineBlame = { fg = p.faint, italic = true },

		-- telescope (rest is derived in plugs/telescope.lua)
		TelescopeMatching = { bold = true, underline = true },
		TelescopeSelectionCaret = { fg = p.ink, bold = true },

		-- cmp
		CmpItemAbbr = { fg = p.ink },
		CmpItemAbbrMatch = { fg = p.ink, bold = true, underline = true },
		CmpItemAbbrMatchFuzzy = { fg = p.ink, bold = true },
		CmpItemAbbrDeprecated = { fg = p.mid, strikethrough = true },
		CmpItemKind = { fg = p.mid },
		CmpItemMenu = { fg = p.faint, italic = true },

		-- hop
		HopNextKey = reverse,
		HopNextKey1 = { fg = p.ink, bold = true, underline = true },
		HopNextKey2 = { fg = p.mid, underline = true },
		HopUnmatched = { fg = p.faint },
	}
end

local function apply()
	local mode = vim.env.THEME_MODE == "light" and "light" or "dark"
	local p = palettes[mode]

	vim.cmd("hi clear")
	vim.o.background = mode
	vim.g.colors_name = "eink"

	-- flatten every existing group so nothing inherits hue from defaults or plugins
	for name, def in pairs(vim.api.nvim_get_hl(0, {})) do
		if not def.link then
			vim.api.nvim_set_hl(0, name, {})
		end
	end

	for name, def in pairs(groups(p)) do
		vim.api.nvim_set_hl(0, name, def)
	end

	-- plugins like devicons define colored groups after load
	vim.schedule(function()
		for name, _ in pairs(vim.api.nvim_get_hl(0, {})) do
			if name:match("^DevIcon") then
				vim.api.nvim_set_hl(0, name, { fg = p.mid })
			end
		end
	end)

	vim.luatheme = lualine_theme(p)
end

vim.colorschemes.eink = apply
