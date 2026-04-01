local M = {}

M.config = {
  -- Number of candidates to show in the Telescope picker
  candidates = 10,
  -- Separator between adjective and animal
  separator = "-",
  -- Optional prefix (e.g., "pk/" for your initials)
  prefix = "",
}

-- ~180 adjectives
local adjectives = {
  "able", "afraid", "aged", "agile", "alert", "amber", "ancient", "angry",
  "arctic", "arid", "astral", "atomic", "autumn", "azure", "barren", "bitter",
  "blazing", "bleak", "blind", "bold", "brave", "brief", "bright", "brittle",
  "broad", "bronze", "brisk", "calm", "casual", "clever", "cobalt", "cold",
  "coral", "cosmic", "covert", "crisp", "cruel", "curious", "curved", "cyan",
  "damp", "daring", "dark", "dawn", "deep", "dense", "dire", "distant",
  "dizzy", "double", "dreamy", "dry", "dull", "dusk", "dusty", "eager",
  "early", "earthy", "easy", "eerie", "elder", "empty", "endless", "epic",
  "equal", "errant", "even", "exact", "exotic", "faded", "faint", "fallen",
  "feral", "ferric", "few", "fierce", "fiery", "final", "first", "fixed",
  "flashy", "flat", "fleet", "flint", "fluid", "foggy", "fond", "frail",
  "free", "fresh", "frigid", "frozen", "frugal", "full", "fused", "fuzzy",
  "gentle", "giant", "giddy", "gilt", "glad", "glass", "gleamy", "global",
  "golden", "grand", "grave", "great", "green", "grim", "gruff", "gusty",
  "half", "happy", "hardy", "hasty", "hazy", "heavy", "hidden", "hollow",
  "honest", "humble", "hushed", "icy", "idle", "inner", "iron", "ivory",
  "jade", "jagged", "jolly", "keen", "kind", "knotty", "known", "lame",
  "large", "last", "late", "lazy", "lean", "light", "limber", "liquid",
  "little", "lively", "lone", "long", "lost", "loud", "low", "lucid",
  "lunar", "lush", "mad", "magic", "marble", "meek", "mellow", "mental",
  "mild", "misty", "modern", "molten", "mossy", "muted", "narrow", "neat",
  "neural", "nimble", "noble", "noisy", "numb", "odd", "olive", "open",
  "outer", "pale", "pastel", "past", "placid", "plain", "plush", "polar",
  "polite", "primal", "prime", "proud", "pure", "quick", "quiet", "rare",
  "rapid", "raw", "ready", "red", "remote", "rigid", "rogue", "rough",
  "round", "royal", "ruby", "rugged", "rustic", "sacred", "safe", "sandy",
  "scenic", "secret", "serene", "sharp", "sheer", "shy", "silent", "silky",
  "silver", "simple", "slick", "slim", "slow", "small", "smart", "smoky",
  "smooth", "snowy", "sober", "soft", "solar", "solid", "somber", "spare",
  "stark", "steady", "steep", "stern", "still", "stony", "storm", "stout",
  "strong", "subtle", "sudden", "sunny", "super", "sure", "sweet", "swift",
  "tall", "tame", "tawny", "tense", "thick", "thin", "tidal", "tight",
  "tiny", "tough", "tropic", "true", "turbid", "twin", "ultra", "umbral",
  "unique", "upper", "urban", "vacant", "vague", "valid", "vast", "velvet",
  "verdant", "vivid", "void", "warm", "wary", "weary", "west", "wet",
  "whole", "wide", "wild", "windy", "winter", "wiry", "wise", "witty",
  "woven", "young", "zany", "zealous", "zinc",
}

-- ~200 animals
local animals = {
  "addax", "albatross", "alligator", "alpaca", "anchovy", "ant", "anteater",
  "antelope", "ape", "armadillo", "asp", "baboon", "badger", "barracuda",
  "basilisk", "bass", "bat", "bear", "beaver", "beetle", "bison", "bluebird",
  "boa", "boar", "bobcat", "bongo", "booby", "buffalo", "bunny", "buzzard",
  "camel", "canary", "capybara", "cardinal", "caribou", "carp", "cat",
  "catfish", "cheetah", "chicken", "chipmunk", "cicada", "clam", "cobra",
  "cockatoo", "cod", "condor", "corgi", "cormorant", "cougar", "cow",
  "coyote", "crab", "crane", "cricket", "crow", "cuckoo", "curlew",
  "darter", "deer", "dingo", "dog", "dolphin", "donkey", "dove", "dragon",
  "dragonfly", "duck", "dugong", "eagle", "eel", "egret", "eland", "elk",
  "emu", "ermine", "falcon", "ferret", "finch", "firefly", "flamingo",
  "flounder", "fly", "fox", "frog", "gannet", "gar", "gazelle", "gecko",
  "gerbil", "gibbon", "goat", "goose", "gopher", "gorilla", "grackle",
  "grouse", "grub", "gull", "hamster", "hare", "hawk", "hedgehog", "heron",
  "herring", "hippo", "hog", "hornet", "horse", "hound", "hyena", "ibex",
  "ibis", "iguana", "impala", "jackal", "jackdaw", "jaguar", "jay",
  "jellyfish", "kestrel", "kingfish", "kite", "kiwi", "koala", "koi",
  "komodo", "krill", "kudu", "lark", "lemming", "lemur", "leopard", "liger",
  "lion", "lizard", "llama", "lobster", "locust", "loon", "lynx", "macaw",
  "mackerel", "magpie", "mammoth", "manatee", "mandrill", "manta", "marlin",
  "marmot", "marten", "mastodon", "meerkat", "merlin", "mink", "minnow",
  "mole", "mollusk", "mongoose", "monkey", "moose", "moth", "mouse", "mule",
  "muskox", "narwhal", "newt", "nutria", "ocelot", "octopus", "okapi",
  "opossum", "orca", "oriole", "osprey", "ostrich", "otter", "owl", "ox",
  "panda", "panther", "parrot", "partridge", "peacock", "pelican", "penguin",
  "perch", "pheasant", "pigeon", "pike", "piranha", "platypus", "plover",
  "pony", "porcupine", "possum", "prawn", "puffin", "puma", "python",
  "quail", "quetzal", "rabbit", "raccoon", "ram", "raven", "ray",
  "redfish", "reindeer", "rhino", "roadrunner", "robin", "rooster",
  "sailfish", "salamander", "salmon", "sardine", "scorpion", "seahorse",
  "seal", "shark", "shrew", "shrimp", "skink", "skunk", "sloth", "slug",
  "smelt", "snail", "snake", "snapper", "snipe", "sparrow", "spider",
  "squid", "squirrel", "starfish", "stingray", "stork", "sturgeon",
  "sunfish", "swallow", "swan", "tapir", "tarpon", "termite", "tern",
  "thrush", "tick", "tiger", "toad", "tortoise", "toucan", "trout",
  "tuna", "turkey", "turtle", "viper", "vole", "vulture", "walrus",
  "warthog", "wasp", "weasel", "whale", "wolf", "wolverine", "wombat",
  "woodcock", "woodpecker", "wren", "yak", "zebra",
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  vim.api.nvim_create_user_command("GitBranch", function()
    M.pick_branch()
  end, { desc = "Generate random branch names and pick one via Telescope" })

  vim.api.nvim_create_user_command("GitBranchInsert", function()
    M.pick_branch({ insert = true })
  end, { desc = "Generate random branch names and insert at cursor" })
end

--- Generate a single random name
---@return string
function M.generate_name()
  local adj = adjectives[math.random(#adjectives)]
  local animal = animals[math.random(#animals)]
  return M.config.prefix .. adj .. M.config.separator .. animal
end

--- Generate n unique candidate names
---@param n? integer
---@return string[]
function M.generate_candidates(n)
  n = n or M.config.candidates
  local seen = {}
  local results = {}
  local attempts = 0
  while #results < n and attempts < n * 10 do
    local name = M.generate_name()
    if not seen[name] then
      seen[name] = true
      results[#results + 1] = name
    end
    attempts = attempts + 1
  end
  return results
end

--- Open a Telescope picker with random branch name candidates
---@param opts? { insert?: boolean }
function M.pick_branch(opts)
  opts = opts or {}
  math.randomseed(os.clock() * 1e6 + os.time())

  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    vim.notify("random-branch.nvim requires telescope.nvim", vim.log.levels.ERROR)
    return
  end
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local candidates = M.generate_candidates()

  pickers
    .new({}, {
      prompt_title = "Random Branch Name",
      finder = finders.new_table({ results = candidates }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        -- <CR> to checkout -b
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if not selection then
            return
          end
          local name = selection[1]

          if opts.insert then
            vim.api.nvim_put({ name }, "c", true, true)
            return
          end

          -- Confirm before creating the branch
          vim.ui.select({ "Yes", "No" }, {
            prompt = "Create and switch to branch '" .. name .. "'?",
          }, function(choice)
            if choice == "Yes" then
              local result = vim.fn.system({ "git", "checkout", "-b", name })
              if vim.v.shell_error == 0 then
                vim.notify("Switched to new branch: " .. name, vim.log.levels.INFO)
              else
                vim.notify("git error: " .. result, vim.log.levels.ERROR)
              end
            end
          end)
        end)

        -- <C-r> to regenerate the list
        map("i", "<C-r>", function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          current_picker:refresh(
            finders.new_table({ results = M.generate_candidates() }),
            { reset_prompt = true }
          )
        end)

        -- <C-y> to yank the selected name to clipboard
        map("i", "<C-y>", function()
          local selection = action_state.get_selected_entry()
          if selection then
            vim.fn.setreg("+", selection[1])
            vim.notify("Copied: " .. selection[1], vim.log.levels.INFO)
          end
        end)

        return true
      end,
    })
    :find()
end

return M
