local os_name = os.getenv("OS")
local wayland_display = os.getenv("WAYLAND_DISPLAY")


if os_name == "Darwin" then
	vim.g.clpboard = {
		name = "macOS-clpboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
		cache_enabled = 0,
	}
elseif wayland_display ~= nil then
	vim.g.clipboad = {
		name = "wl-clipboard",
		copy = {
			["+"] = "wl-copy --foreground --type text/plain",
			["*"] = "wl-copy --foreground --type text/plain",
		},
		paste = {
			["+"] = "wl-paste --no-newline",
			["*"] = "wl-paste --no-newline",
		},
		cache_enabled = 0,
	}
else
	vim.g.clipboard = {
		name = "X11Clipboard",
		copy = {
			["+"] = "xclip -selection clipboard -in",
			["*"] = "xclip -selection primary -in",
		},
		paste = {
			["+"] = "xclip -selection clipboard -out",
			["*"] = "xclip -selection primary -out",
		},
		cache_enabled = 0,
	}
end

vim.opt.number = true
vim.opt.relativenumber = true

