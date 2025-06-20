-- NDE Command Suite
-- Centralized command system for all NDE functionality

local M = {}

-- Import modules
local tips = require('nde.tips')
local dynamic_loader = require('performance.dynamic_loader')

-- Main NDE command handler
local function handle_nde_command(opts)
  local args = vim.split(opts.args, ' ', { trimempty = true })
  local cmd = args[1] or 'help'
  local subcmd = args[2]
  local action = args[3]

  -- Tips commands
  if cmd == 'tips' then
    if subcmd == 'on' then
      tips.enable()
    elseif subcmd == 'off' then
      tips.disable()
    else
      tips.toggle()
    end
    
  elseif cmd == 'tip' then
    if subcmd == 'show' then
      tips.show_current()
    elseif subcmd == 'next' then
      tips.show_next()
    elseif subcmd == 'random' then
      tips.show_random()
    else
      tips.show_current()
    end
    
  -- Dynamic loader commands
  elseif cmd == 'dynamicloader' then
    if subcmd == 'stats' then
      dynamic_loader.nde_stats()
    elseif subcmd == 'languages' then
      dynamic_loader.nde_languages()
    elseif subcmd == 'formatters' then
      dynamic_loader.nde_formatters()
    elseif subcmd == 'clearcache' then
      dynamic_loader.nde_clearcache()
    else
      -- Show dynamic loader help
      vim.notify(
        '🚀 NDE Dynamic Loader Commands:\n\n' ..
        '📊 :NDE dynamicloader stats - Performance overview\n' ..
        '🎯 :NDE dynamicloader languages - Language status\n' ..
        '✨ :NDE dynamicloader formatters - Formatter status\n' ..
        '🧹 :NDE dynamicloader clearcache - Clear all caches\n\n' ..
        '💡 TIP: Tab completion available!',
        vim.log.levels.INFO,
        { title = '🚀 NDE Dynamic Loader Help', timeout = 6000 }
      )
    end
    
  -- General commands
  elseif cmd == 'welcome' then
    tips.show_welcome()
    
  elseif cmd == 'status' then
    tips.show_status()
    
  elseif cmd == 'help' or cmd == '' then
    -- Main help menu
    vim.notify(
      '🎯 NDE Command Suite:\n\n' ..
      '💡 TIPS SYSTEM:\n' ..
      '   :NDE tips on/off - Toggle tips\n' ..
      '   :NDE tip show/next/random - Control tips\n\n' ..
      '🚀 DYNAMIC LOADER:\n' ..
      '   :NDE dynamicloader stats - Performance stats\n' ..
      '   :NDE dynamicloader languages - Language status\n' ..
      '   :NDE dynamicloader formatters - Formatter status\n' ..
      '   :NDE dynamicloader clearcache - Clear caches\n\n' ..
      '🎉 GENERAL:\n' ..
      '   :NDE welcome - Show welcome message\n' ..
      '   :NDE status - Show NDE status\n\n' ..
      '💡 TIP: All commands support tab completion!',
      vim.log.levels.INFO,
      { title = '🚀 NDE Command Center', timeout = 10000 }
    )
    
  else
    -- Unknown command
    vim.notify(
      '❌ Unknown NDE command: ' .. cmd .. '\n\n' ..
      'Use :NDE help to see all available commands',
      vim.log.levels.WARN,
      { title = '🚀 NDE Command Suite' }
    )
  end
end

-- Tab completion function
local function complete_nde_command(ArgLead, CmdLine, CursorPos)
  local args = vim.split(CmdLine, ' ', { trimempty = true })
  local arg_count = #args
  
  -- If we're still typing the command name
  if CmdLine:sub(-1) ~= ' ' then
    arg_count = arg_count - 1
  end
  
  if arg_count == 1 then
    -- First level commands
    local commands = {
      'help', 'tips', 'tip', 'dynamicloader', 
      'welcome', 'status'
    }
    return vim.tbl_filter(function(cmd)
      return cmd:match('^' .. vim.pesc(ArgLead))
    end, commands)
    
  elseif arg_count == 2 then
    local cmd = args[2]
    if cmd == 'tips' then
      return { 'on', 'off' }
    elseif cmd == 'tip' then
      return { 'show', 'next', 'random' }
    elseif cmd == 'dynamicloader' then
      return { 'stats', 'languages', 'formatters', 'clearcache' }
    end
  end
  
  return {}
end

-- Setup the main NDE command
function M.setup()
  vim.api.nvim_create_user_command('NDE', handle_nde_command, {
    nargs = '*',
    complete = complete_nde_command,
    desc = 'NDE Command Suite - Type :NDE help for all commands'
  })
end

return M

