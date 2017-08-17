-- -----------------
-- Setup environment
-- -----------------

--Auto reload config on save
function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

--Disable animations
hs.window.animationDuration = 0

--Modifier shortcuts
local hyper = {"cmd","alt","ctrl","shift"}
local yankkey = {"cmd","alt","ctrl"}

--Function creation
--For x and y: use 0 to expand fully in that direction, 0.5 to expand halfway
--For w and h: use 1 for full, 0.5 for half
function push(x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w * x)
  f.y = max.y + (max.h * y)
  f.w = max.w * w
  f.h = max.h * h
  win:setFrame(f)
end

--System wide hyper+hjkl movement keys
hs.hotkey.bind(hyper, "h", function() hs.eventtap.keyStroke({},"left") end)
hs.hotkey.bind(hyper, "j", function() hs.eventtap.keyStroke({},"down") end)
hs.hotkey.bind(hyper, "k", function() hs.eventtap.keyStroke({},"up") end)
hs.hotkey.bind(hyper, "l", function() hs.eventtap.keyStroke({},"right") end)

--Window Management
hs.hotkey.bind(yankkey, "j", function() push(0,0,0.5,1) end)
hs.hotkey.bind(yankkey, "l", function() push(0.5,0,0.5,1) end)
hs.hotkey.bind(yankkey, "i", function() push(0,0,1,0.5) end)
hs.hotkey.bind(yankkey, ",", function() push(0,0.5,1,0.5) end)
hs.hotkey.bind(yankkey, "k", function() push(0,0,1,1) end)
hs.hotkey.bind(yankkey, ".", function() push(0.5,0.5,0.5,0.5) end)
hs.hotkey.bind(yankkey, "m", function() push(0,0.5,0.5,0.5) end)
hs.hotkey.bind(yankkey, "o", function() push(0.5,0,0.5,0.5) end)
hs.hotkey.bind(yankkey, "u", function() push(0,0,0.5,0.5) end)

--App shortcutes
hs.hotkey.bind(hyper, "c", function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(hyper, "s", function() hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind(hyper, "d", function() hs.application.launchOrFocus("Discord") end)
hs.hotkey.bind(hyper, "e", function() hs.application.launchOrFocus("Microsoft Outlook") end)
hs.hotkey.bind(hyper, "m", function() hs.application.launchOrFocus("Messages") end)
hs.hotkey.bind(hyper, "i", function() hs.application.launchOrFocus("iTunes") end)

--Focus windows
local function focus(direction)
  local fn = "focusWindow" .. (direction:gsub("^%l", string.upper))

  return function()
    local win = hs.window:focusedWindow()
    if not win then return end

    win[fn]()
  end
end

-- Modal window layouts
hs.hints.showTitleThresh = 0
hs.hints.style = "vimperator"
hs.hotkey.bind(hyper, 'f', hs.hints.windowHints)

hs.hotkey.bind(hyper, "up", focus("north"))
hs.hotkey.bind(hyper, "right", focus("east"))
hs.hotkey.bind(hyper, "down", focus("south"))
hs.hotkey.bind(hyper, "left", focus("west"))


hs.grid.ui.showExtraKeys = false
hs.grid.ui.textSize = 25
hs.grid.setGrid('10x4')
