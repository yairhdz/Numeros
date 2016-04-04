---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
 local widget  = require( "widget" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
local nextSceneButton
local numeros = {}
local currentNumber = nil
local currentIdx = 1
local time = 1000
local nums = { [0] = "cero", "Uno", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", "Ocho", "Nueve"}
---------------------------------------------------------------------------------

local function creaNumeros() 
  local offsetX = 100
  local y = 100
  for i = 0, #nums do
    print(nums[i])
    local numeroDg = display.newGroup()
    local cuadro = display.newRect(i * offsetX + 50, y, 50, 50)
    cuadro:setFillColor(0.5, 0.6, 0.7)

    local numero = display.newText(i, i * offsetX + 50, y, native.systemFont, 40 )
    numero:setFillColor(1, 1, 1)

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
    timer.performWithDelay(time, function() activateTouch() end)
  end
end


function animaNumeros() 
  local currentNumber = numeros[currentIdx]
  local texto = nil
  
  transition.moveTo(currentNumber, { time = time, x = 500, y = 500}) 
  timer.performWithDelay(time, function() 
      transition.scaleTo(currentNumber, {xScale = 2, yScale = 2})
      texto = display.newText(nums[currentIdx - 1], currentNumber.x, currentNumber.y + 100, native.systemFont, 80 )
  end)

  timer.performWithDelay(time * 2, function() 
      transition.scaleTo(currentNumber, {xScale = 1, yScale = 1, onComplete = animaSiguiente}) 
  end)

  timer.performWithDelay(time * 2 + 500, function() 
      texto:removeSelf()
      transition.moveTo(currentNumber, {time = time, x = currentNumber.xStart, y = currentNumber.yStart}) 
  end)
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
   

-- Function to handle button events
local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
    end
end

-- Create the widget
local button1 = widget.newButton(
    {
        label = "Repetir",
        font = native.systemFontBold,
        fontSize = 40,
        onEvent = touchListener,
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

-- Center the button


-- Change the button's label text
--button1:setLabel( "Shape" )
  end


  function scene:create( event )
    local sceneGroup = self.view
    local fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    fondo:setFillColor(0.2,0.4,0.9)
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