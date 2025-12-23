-- custom-shell
require("custom-shell"):setup({
    history_path = "default",
    save_history = true,
})

-- bunny
require("bunny"):setup({
  hops = {
    { key = "n",          path = "/mnt/HOUSE/nonlinear-vault", desc = "nonlinear vault" },
    { key = "p",          path = "/mnt/HOUSE/personal",        desc = "personal"        },
    { key = "d",          path = "/mnt/HOUSE/downloads",       desc = "downloads"       },
    { key = "z",          path = "/mnt/HOUSE/dev",             desc = "dev"             },
    { key = ".",          path = "~/dotfiles",                 desc = "dotfiles"        },
    { key = "/",          path = "/",                          desc = "root"            },
    { key = "s",          path = "/nix/store",                 desc = "nix store"       },
    { key = "h",          path = "~",                          desc = "home"            },
    { key = "c",          path = "~/.config",                  desc = "config files"    },
    { key = { "l", "s" }, path = "~/.local/share",             desc = "local share"     },
    { key = { "l", "b" }, path = "~/.local/bin",               desc = "local bin"       },
    { key = { "l", "t" }, path = "~/.local/state",             desc = "local state"     },

  },
  desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
  ephemeral = true, -- Enable ephemeral hops, default is true
  tabs = false, -- Enable tab hops, default is true
  notify = false, -- Notify after hopping, default is false
  fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})

-- starship
require("starship"):setup({
    -- Custom starship configuration file to use
    config_file = "~/.config/starship.toml",
})

-- hover-after-moved
require("hover-after-moved"):setup()

-- gvfs
require("gvfs"):setup()

-- custom: move tabs back to header
function Tabs.height() return 0 end

Header:children_add(function()
  if #cx.tabs == 1 then return "" end
  local spans = {}
  for i = 1, #cx.tabs do
    spans[#spans + 1] = ui.Span(" " .. i .. " ")
  end
  spans[cx.tabs.idx]:reverse()
  return ui.Line(spans)
end, 9000, Header.RIGHT)


-- custom: some padding
local old_layout = Tab.layout

Tab.layout = function(self, ...)
  self._area = ui.Rect({ x = self._area.x, y = self._area.y + 1, w = self._area.w, h = self._area.h - 2 })
  return old_layout(self, ...)
end


-- custom: remove mode from status
Status:children_remove(1, Status._left)
