---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
local nextSceneButton
local numeros = {}
local currentNumber = nil
local currentIdx = 1
---------------------------------------------------------------------------------

local function creaNumeros() 
  local offsetX = 100
  local y = 100
  for i = 0, 9 do
    local numeroDg = display.newGroup()
    local cuadro = display.newRect(i * offsetX + 50, y, 50, 50)
    cuadro:setFillColor(0, 0.6, 0.3)

    local numero = display.newText(i, i * offsetX + 50, y, native.systemFont, 40 )
    numero:setFillColor(1,0,0)

    numeroDg:insert(cuadro,true)
    numeroDg:insert(numero,true)

    numeroDg.x = i * offsetX + 50
    numeroDg.y = y

    numeroDg.xStart = i * offsetX + 50
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
    -- Ya terminaron de mostrarse todos los numero
    -- se tiene que activar el touch de cada uno
    print("ACTIVAR TOUCH")
    activateTouch()
  end
end


function animaNumeros() 
  local currentNumber = numeros[currentIdx]
  local time = 100
  transition.moveTo(currentNumber, { time = time, x = 500, y = 500}) 
  timer.performWithDelay(time, function() transition.scaleTo(currentNumber, {xScale = 2, yScale = 2}) end)
  timer.performWithDelay(time * 2, function() transition.scaleTo(currentNumber, {xScale = 1, yScale = 1, onComplete = animaSiguiente}) end)
  timer.performWithDelay(time * 2 + 500, function() transition.moveTo(currentNumber, {time = time, x = currentNumber.xStart, y = currentNumber.yStart}) end)
end

local function touchListener( event )
  if event.phase == "ended" then
    print("TOUCHED")
    currentIdx = 1
    animaNumeros()
    event.target:removeSelf()
  end
end


function activateTouch()
  local repetirButton = display.newRect(300, 300, 200, 50)
  repetirButton:setFillColor(0.8, 0.2, 0.1)
  repetirButton:addEventListener("touch", touchListener)
end


function scene:create( event )
  local sceneGroup = self.view
  local fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
  fondo:setFillColor(0.8,0.2,.9)
  creaNumeros()
  animaNumeros()

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
    local title = self:getObjectByName( "Title" )
    title.x = display.contentWidth / 2
    title.y = display.contentHeight / 2
    title.size = display.contentWidth / 10
    local goToScene1Btn = self:getObjectByName( "GoToScene1Btn" )
    goToScene1Btn.x = display.contentWidth - 95
    goToScene1Btn.y = display.contentHeight - 35
    local goToScene1Text = self:getObjectByName( "GoToScene1Text" )
    goToScene1Text.x = display.contentWidth - 92
    goToScene1Text.y = display.contentHeight - 35
  elseif phase == "did" then
    -- Called when the scene is now on screen
    -- 
    -- INSERT code here to make the scene come alive
    -- e.g. start timers, begin animation, play audio, etc
    nextSceneButton = self:getObjectByName( "GoToScene1Btn" )
    if nextSceneButton then
      -- touch listener for the button
      function nextSceneButton:touch ( event )
        local phase = event.phase
        if "ended" == phase then
          composer.gotoScene( "view.onLoadApp", { effect = "fade", time = 300 } )
        end
      end
      -- add the touch event listener to the button
      nextSceneButton:addEventListener( "touch", nextSceneButton )
    end
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
