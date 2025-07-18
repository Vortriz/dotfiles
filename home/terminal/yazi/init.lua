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
    { key = "1",          path = "/mnt/HOUSE/dev",             desc = "dev"             },
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
  tabs = true, -- Enable tab hops, default is true
  notify = false, -- Notify after hopping, default is false
  fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})

-- starship
require("starship"):setup({
    -- Custom starship configuration file to use
    config_file = "~/.config/starship.toml",
})
