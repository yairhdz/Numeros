---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"
--require("mobdebug").start()

-- load scene1
composer.gotoScene( "view.onLoadApp", {effect = "fade", time = 1000})

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)

