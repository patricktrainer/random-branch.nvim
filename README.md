# random-branch.nvim

Generate random `adjective-animal` git branch names with a Telescope picker.

~180 adjectives × ~200 animals = ~36,000 possible combinations.

## Requirements

- Neovim >= 0.8
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "patricktrainer/random-branch.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("random-branch").setup()
  end,
  keys = {
    { "<leader>gb", "<cmd>GitBranch<cr>", desc = "Random git branch" },
  },
}
```

## Configuration

```lua
require("random-branch").setup({
  candidates = 10,   -- number of names shown per roll
  separator = "-",   -- delimiter between adjective and animal
  prefix = "",       -- optional prefix, e.g. "pk/" or "feat/"
})
```

## Commands

| Command            | Description                                      |
| ------------------ | ------------------------------------------------ |
| `:GitBranch`       | Open picker → select → `git checkout -b <name>`  |
| `:GitBranchInsert` | Open picker → select → insert name at cursor     |

## Picker Keymaps

| Key     | Action                              |
| ------- | ----------------------------------- |
| `<CR>`  | Create & checkout the selected branch (with confirmation) |
| `<C-r>` | Reroll a fresh batch of names       |
| `<C-y>` | Yank selected name to `+` register  |

## API

```lua
local rb = require("random-branch")

rb.generate_name()         -- returns a single random name
rb.generate_candidates(n)  -- returns n unique names
rb.pick_branch()           -- opens the Telescope picker
rb.pick_branch({ insert = true })  -- picker inserts at cursor instead
```

## License

MIT
