---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local widget  = require( "widget" )
local texttospeech = require('plugin.texttospeech')
local setup = require("system.setup")

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
local nextSceneButton
local numeros = {}
local currentNumber = nil
local currentIdx = 1
local time = 1000
local nums = { [0] = "cero", "Uno", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", "Ocho", "Nueve"}
local viewGroup = display.newGroup()
local currentScene = composer.getSceneName( "current" )

---------------------------------------------------------------------------------
texttospeech.init()

local function creaNumeros() 
  local offsetX = 90
  local y = 300
  for i = 0, #nums do
    print(nums[i])
    local numeroDg = display.newGroup()
    local cuadro = display.newRect(0, 0, 50, 50)
    cuadro:setFillColor(0.5, 0.6, 0.7)

    local numero = display.newText(i, 0, 0, native.systemFont, 40 )
    numero:setFillColor(1, 1, 1)

    numeroDg:insert(cuadro,true)
    numeroDg:insert(numero,true)

    numeroDg.x = i * offsetX + 100
    numeroDg.y = y

    numeroDg.xStart = i * offsetX + 100
    numeroDg.yStart = y
    numeroDg.arrPos = i

    table.insert(numeros, numeroDg)
  end
end



local function animaSiguiente( obj )
  print( "Transition 2 completed on object: " .. tostring( obj ) )
  if currentIdx < #numeros then
    currentIdx = currentIdx + 1
    animaNumeros()
  else
    showOptions() 
  end
end


function animaNumeros() 
  local currentNumber = numeros[currentIdx]
  local texto = nil
  local img = nil

  transition.moveTo(currentNumber, { time = time, x = 300, y = 500}) 
  timer.performWithDelay(time, function() 
      transition.scaleTo(currentNumber, {xScale = 2.5, yScale = 2.5})
      texto = display.newText(nums[currentIdx - 1], currentNumber.x, currentNumber.y + 100, native.systemFont, 80 )
      img = display.newImageRect("assets/" .. (currentIdx - 1) .. ".png", 500, 250)
      img.x = currentNumber.x + 350
      img.y = currentNumber.y + 35
      if setup.soundError then
        local numberSound = audio.loadSound( "assets/sound/" .. nums[currentIdx -1] .. ".mp3")
        local laserChannel = audio.play( numberSound )
      else
        texttospeech.speak(nums[currentIdx - 1], {language = 'es-MX', voice = 'default'}) 
      end
    end)

  timer.performWithDelay(time * 2 + (currentIdx * (time / 2)), function() 
      texto:removeSelf()
      img:removeSelf()
      transition.moveTo(currentNumber, {time = time, x = currentNumber.xStart, y = currentNumber.yStart, xScale = 1, yScale = 1, onComplete = animaSiguiente}) 
    end)
end

local function touchListener( event )
  if event.phase == "ended" then
    print("TOUCHED")
    currentIdx = 1
    animaNumeros()
    event.target:removeSelf()
    event.target.menu:removeSelf()
  end
end

local function menuListener( event )
  if event.phase == "ended" then
    composer.removeScene(currentScene)
    composer.gotoScene("view.menu")
  end
end

function showOptions()
  local repetirButton = widget.newButton(
    {
      label = "Repetir",
      font = native.systemFontBold,
      fontSize = 40,
      onEvent = touchListener,
      emboss = false,
      -- Properties for a rounded rectangle button
      shape = "roundedRect",
      x = display.contentCenterX + 350,
      y = display.contentCenterY + 220,
      width = 200,
      height = 60,
      cornerRadius = 2,
      fillColor = { default={0.9,0.9,0.4,1}, over={0.9,0.9,0.4,0.6} },
      strokeColor = { default={0,0,0,1}, over={0.8,0.8,1,1} },
      strokeWidth = 4
    }
  )

  local menuButton = widget.newButton(
    {
      label = "Menu",
      font = native.systemFontBold,
      fontSize = 40,
      onEvent = menuListener,
      emboss = false,
      -- Properties for a rounded rectangle button
      shape = "roundedRect",
      x = display.contentCenterX + 350,
      y = display.contentCenterY + 300,
      width = 200,
      height = 60,
      cornerRadius = 2,
      fillColor = { default={0.9,0.9,0.4,1}, over={0.9,0.9,0.4,0.6} },
      strokeColor = { default={0,0,0,1}, over={0.8,0.8,1,1} },
      strokeWidth = 4
    }
  )

  repetirButton.menu = menuButton
  viewGroup:insert(repetirButton)
  viewGroup:insert(menuButton)
end


function scene:create( event )
  local sceneGroup = self.view

  local fondo = display.newImageRect("assets/pizarron.jpeg", display.actualContentWidth, display.actualContentHeight)
  fondo.x = display.contentCenterX
  fondo.y = display.contentCenterY
  sceneGroup:insert(fondo)
  timer.performWithDelay(500, function()
      creaNumeros()
      animaNumeros()
    end
  )

  -- Called when the scene's view does not exist
  -- 
  -- INSERT code here to initialize the scene
  -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if phase == "will" then
    -- Called when the scene is still off screen and is about to move on screen

  elseif phase == "did" then
    -- Called when the scene is now on screen
    -- 
    -- INSERT code here to make the scene come alive
    -- e.g. start timers, begin animation, play audio, etc

  end 
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if event.phase == "will" then
    -- Called when the scene is on screen and is about to move off screen
    --
    -- INSERT code here to pause the scene
    -- e.g. stop timers, stop animation, unload sounds, etc.)
  elseif phase == "did" then
    -- Called when the scene is now off screen
    if nextSceneButton then
      nextSceneButton:removeEventListener( "touch", nextSceneButton )
    end
  end 
end


function scene:destroy( event )
  local sceneGroup = self.view
  for _,obj in pairs(numeros) do
    viewGroup:insert(obj)
  end
  sceneGroup:removeSelf()
  viewGroup:removeSelf()

  -- Called prior to the removal of scene's "view" (sceneGroup)
  -- 
  -- INSERT code here to cleanup the scene
  -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
