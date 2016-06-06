---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"
local setup = require("system.setup")
--require("mobdebug").start()

-- load scene1
composer.gotoScene( "view.onLoadApp", {effect = "fade", time = 1000})

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)

local texttospeech = require('plugin.texttospeech')

texttospeech.speak("Prueba para saersta disponible el plugin", {  
    language = 'es-MX',
    voice = 'default',
    volume = 0})

if texttospeech.isSpeaking() == nil then
  print("NO HABLO")
  setup.soundError = true
end


