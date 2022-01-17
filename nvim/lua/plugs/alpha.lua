Plug 'kyazdani42/nvim-web-devicons'
Plug "goolord/alpha-nvim"

vim.loaded.start_alpha = function()
    local if_nil = vim.F.if_nil
    local fnamemodify = vim.fn.fnamemodify
    local filereadable = vim.fn.filereadable

    -- dev icons required for alpha-nvim
    require("nvim-web-devicons").setup {}

    local alpha = require("alpha")

    local DISPLAY_WIDTH = 60

    local function format_row(row)
        local len = string.len(row)
        return row .. string.rep(" ", DISPLAY_WIDTH - len)
    end

    local function button(sc, txt, keybind, keybind_opts)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

        local opts = {
            position = "center",
            shortcut = " " .. sc,
            cursor = 62,
            width = DISPLAY_WIDTH,
            align_shortcut = "right",
            hl_shortcut = {
                { "Number", 1, #sc + 1 },
            },
            shrink_margin = false,
        }
        if keybind then
            keybind_opts = if_nil(keybind_opts, {
                noremap = true,
                silent = true,
                nowait = true
            })
            opts.keymap = {
                "n", sc_, keybind, {
                    noremap = false, silent = true, nowait = true
                }
            }
        end

        local function on_press()
            local replace = vim.api.nvim_replace_termcodes
            local key = replace(keybind .. "<Ignore>", true, false, true)
            vim.api.nvim_feedkeys(key, "normal", true)
        end

        return {
            type = "button",
            val = txt,
            on_press = on_press,
            opts = opts,
        }
    end

    local nvim_web_devicons = {
        enabled = true,
        highlight = "Operator",
    }

    local function get_extension(fn)
        local match = fn:match("^.+(%..+)$")
        local ext = ""
        if match ~= nil then
            ext = match:sub(2)
        end
        return ext
    end

    local function icon(fn)
        local nwd = require("nvim-web-devicons")
        local ext = get_extension(fn)
    return nwd.get_icon(fn, ext, { default = true })
    end

    local function file_button(fn, sc, short_fn)
        short_fn = if_nil(short_fn, fn)
        local ico_txt
        local fb_hl = {}
        if nvim_web_devicons.enabled then
            local ico, hl = icon(fn)
            local hl_option_type = type(nvim_web_devicons.highlight)
            if hl_option_type == "boolean" then
                if hl and nvim_web_devicons.highlight then
                    table.insert(fb_hl, { hl, 0, 1 })
                end
            end
            if hl_option_type == "string" then
                table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
            end
            ico_txt = ico .. "  "
        else
            ico_txt = ""
        end
        local file_button_el = button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. " <CR>")
        local fn_start = short_fn:match(".*/")
        if fn_start ~= nil then
            table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
        end
        file_button_el.opts.hl = fb_hl
        return file_button_el
    end

    local default_mru_ignore = { "gitcommit" }

    local mru_opts = {
        ignore = function(path, ext)
            return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
        end,
    }

    local function _get_old_files(opts, items_number, cwd)
        local oldfiles = {}
        for _, v in pairs(vim.v.oldfiles) do
            if #oldfiles == items_number then
                break
            end
            local cwd_cond
            if not cwd then
                cwd_cond = true
            else
                cwd_cond = vim.startswith(v, cwd)
            end
            local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
            if (filereadable(v) == 1) and cwd_cond and not ignore then
                oldfiles[#oldfiles + 1] = v
            end
        end
        return oldfiles
    end

    local working_dirs = {}

    local function _get_base_dir(full_path)
        for i, dir in ipairs(working_dirs) do
            if full_path:find(dir) == 1 then
                return dir:gsub("%%", "")
            end
        end
        return ""
    end

    local MAX_LENGTH = 40

    local function get_file_name(path)
        return path:sub(if_nil(path:find("/[^/]*$"), 0) + 1)
    end

    local function _format_file_path(full_path)
        if full_path:find("~/") == 1 then
            full_path = full_path:sub(3)
        end
        local base_dir = _get_base_dir(full_path)
        local short_base = get_file_name(base_dir)
        local path = full_path:sub(base_dir:len() + 1)

        local over_len = path:len() + short_base:len() - MAX_LENGTH
        if over_len <= 0 then
            return short_base .. path
        end

        local start  = path:find("/", over_len)
        if start then
            if short_base ~= "" then
                short_base = short_base .. "/"
            end
            return short_base .. "..." .. path:sub(start)
        else
            return path:sub(if_nil(path:find("/[^/]*$"), 0) + 1)
        end
    end

    local function _build_button_tbl(oldfiles, start, cwd)
        local tbl = {}
        for i, fn in ipairs(oldfiles) do
            local short_fn
            if cwd then
                short_fn = fnamemodify(fn, ":.")
            else
                short_fn = fnamemodify(fn, ":~")
            end
            short_fn = _format_file_path(if_nil(short_fn, fn))

            local file_button_el = file_button(fn, tostring(i + start - 1), short_fn)
            tbl[i] = file_button_el
        end
        return tbl
    end

    local function mru(start, cwd, items_number, opts)
        opts = opts or mru_opts
        items_number = if_nil(items_number, 8)
        local oldfiles = _get_old_files(opts, items_number, cwd)
        return {
            type = "group",
            val = _build_button_tbl(oldfiles, start, cwd),
            opts = {},
        }
    end

    local function mru_title()
        return format_row("MRU " .. fnamemodify(vim.fn.getcwd(), ":~"))
    end

    local section = {
        header = {
            type = "text",
            val = format_row(""),
            opts = {
                hl = "Type",
                shrink_margin = false,
            },
        },
        top_button = {
            type = "group",
            val = {
                button("++", "  new file", "<cmd>ene <CR>"),
            },
        },
        mru = {
            type = "group",
            val = {
                { type = "padding", val = 1 },
                { type = "text", val = format_row("MRU"), opts = { position = "center", hl = "SpecialComment" } },
                { type = "padding", val = 1 },
                {
                    type = "group",
                    val = function()
                        return { mru(0) }
                    end,
                },
            },
        },
        mru_cwd = {
            type = "group",
            val = {
                { type = "padding", val = 1 },
                { type = "text", val = mru_title, opts = { hl = "SpecialComment", position = "center", shrink_margin = false } },
                { type = "padding", val = 1 },
                {
                    type = "group",
                    val = function()
                        return { mru(10, vim.fn.getcwd()) }
                    end,
                    opts = { shrink_margin = false },
                },
            },
        },
        footer = {
            type = "group",
            val = {},
        },
    }

    opts = {
        layout = {
            { type = "padding", val = 1 },
            section.header,
            { type = "padding", val = 1 },
            section.mru,
            section.mru_cwd,
            { type = "padding", val = 1 },
            section.top_button,
            section.footer,
        },
        opts = {
            margin = 5,
        },
    }
    alpha.setup(opts)
end
