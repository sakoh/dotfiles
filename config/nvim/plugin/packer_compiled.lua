-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/sakoh/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/sakoh/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/sakoh/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/sakoh/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/sakoh/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ale = {
    commands = { "ALEEnable" },
    config = { "vim.cmd[[ALEEnable]]" },
    loaded = false,
    needs_bufread = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/opt/ale"
  },
  ["completion-nvim"] = {
    after = { "vim-vsnip-integ", "vim-vsnip" },
    loaded = false,
    needs_bufread = false,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/opt/completion-nvim"
  },
  dracula = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/dracula"
  },
  ["eslint.nvim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/eslint.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\0026\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["iceberg.vim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/iceberg.vim"
  },
  ["jedi-vim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/jedi-vim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/nord-vim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["pgmnt.vim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/pgmnt.vim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["qml.vim"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/qml.vim"
  },
  taskwiki = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/taskwiki"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/vim-closer"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-matchup"] = {
    after_files = { "/home/sakoh/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  },
  ["vim-vsnip"] = {
    load_after = {
      ["completion-nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    after_files = { "/home/sakoh/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ/after/plugin/vsnip_integ.vim" },
    load_after = {
      ["completion-nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  vimwiki = {
    loaded = true,
    path = "/home/sakoh/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\0026\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ALEEnable lua require("packer.load")({'ale'}, { cmd = "ALEEnable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType cmake ++once lua require("packer.load")({'ale'}, { ft = "cmake" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'ale'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType zsh ++once lua require("packer.load")({'ale'}, { ft = "zsh" }, _G.packer_plugins)]]
vim.cmd [[au FileType bash ++once lua require("packer.load")({'ale'}, { ft = "bash" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'ale'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'ale'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'ale'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'ale'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType sh ++once lua require("packer.load")({'ale'}, { ft = "sh" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'ale'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType racket ++once lua require("packer.load")({'ale'}, { ft = "racket" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-matchup'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: ".v:exception | echom "Please check your config for correctness" | echohl None')
end
