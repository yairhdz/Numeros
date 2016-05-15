---------------------------------------------------------------------------------
--
-- ordenar.lua
-- Motor que servira como ejercicio para ordenar los numeros 
-- que fueron mostrados en el ejercicio anterior
-- 
---------------------------------------------------------------------------------
local composer = require( "composer" )
local setup    = require( "system.setup" )

local scene = composer.newScene()
local reorderedNumbers = {}
local numeros = {}
local boxes = {}
local answer = ""


-- -----------------------------------------------------------------------------------------------------------------
-- Local forward references should go local function creaNumeros() 

local function isHover(number, box)
  local fw = number.width * 0.5
  local fh = number.height * 0.5
  if (box.x >= (number.x - fw) and box.x <= (number.x + fw) and box.y >= (number.y - fh) and box.y <= (number.y + fh)) then
    return true
  end
  return false
end

local function getBoxHolder(event)
  local target = event.target
  for i=1,#boxes do
    if(isHover(target, boxes[i])) then
      return boxes[i]
    end
  end
end

local function popUpFail() 
  local popUpDg = display.newGroup()
  local popUp = display.newRoundedRect(0, 0, 600, 400, 5)
  popUp:setFillColor(0.8, 0.6, 0.3)
  popUp.alpha = 0.7

  local text1 = display.newText("Secuencia incorrecta", 0, -50, native.systemFontBold, 46)
  local text2 = display.newText("Intentalo de nuevo.", 0, 50, native.systemFontBold, 36)
  popUpDg:insert(popUp, true)
  popUpDg:insert(text1)
  popUpDg:insert(text2)

  popUpDg.x = display.contentCenterX
  popUpDg.y = display.contentCenterY
  return popUpDg
end

local function popUpSuccess() 
  local popUpDg = display.newGroup()
  local popUp = display.newRoundedRect(0, 0, 600, 400, 5)
  popUp:setFillColor(0.8, 0.6, 0.3)
  popUp.alpha = 0.7

  local text1 = display.newText("Felicidades", 0, -50, native.systemFontBold, 46)
  local text2 = display.newText("Tu respuesta es correcta.", 0, 50, native.systemFontBold, 36)

  local reloadButton = display.newRoundedRect(-100, 150, 100, 50, 5)
  local menuButton = display.newRoundedRect(100, 150, 100, 50, 5)
  popUpDg:insert(popUp, true)
  popUpDg:insert(text1)
  popUpDg:insert(text2)
  popUpDg:insert(reloadButton)
  popUpDg:insert(menuButton)

  popUpDg.x = display.contentCenterX
  popUpDg.y = display.contentCenterY
  return popUpDg
end


local function verifyAnswer()
  print("Correct answer: " .. setup.CORRECT_ANSWER)
  print("Your answer: " .. answer)
  if ( answer == setup.CORRECT_ANSWER ) then
    print("Felicidades, respuesta correcta")
    popUpSuccess()
  else
    print("Lo siento, respuesta incorrecta. Itenta de nuevo")
    local currScene = composer.getSceneName( "current" )
    local popUp = popUpFail()
    timer.performWithDelay(3000, function() 
        popUp:removeSelf()
        composer.removeScene(currScene) 
        composer.gotoScene("view.reloadScene", {params = {reloadScene = currScene}})
      end)
  end
end



local function onTouch( event )
  local t = event.target

  local phase = event.phase
  if "began" == phase then
    -- Make target the top-most object
    local parent = t.parent
    parent:insert( t )
    display.getCurrentStage():setFocus( t )

    -- Spurious events can be sent to the target, e.g. the user presses 
    -- elsewhere on the screen and then moves the finger over the target.
    -- To prevent this, we add this flag. Only when it's true will "move"
    -- events be sent to the target.
    t.isFocus = true

    -- Store initial position
    t.x0 = event.x - t.x
    t.y0 = event.y - t.y

    t.xScale = 2
    t.yScale = 2
  elseif t.isFocus then
    if "moved" == phase then
      -- Make object move (we subtract t.x0,t.y0 so that moves are
      -- relative to initial grab point, rather than object "snapping").
      t.x = event.x - t.x0
      t.y = event.y - t.y0


      -- Gradually show the shape's stroke depending on how much pressure is applied.
      if ( event.pressure ) then
        t:setStrokeColor( 1, 1, 1, event.pressure )
      end
    elseif "ended" == phase or "cancelled" == phase then
      display.getCurrentStage():setFocus( nil )
      t.isFocus = false
      local box = getBoxHolder(event)
      if box then
        event.target.x = box.x
        event.target.y = box.y
        event.target.xScale = 2
        box:insert(event.target, true)
        event.target.width = event.target.width * 2
        event.target.height = event.target.height * 2
        answer = answer .. event.target.arrPos.value
--			  table.insert(answer, event.target.arrPos)
        if ( #answer == #setup.NUMBERS + 1 ) then
          verifyAnswer()
        end
      else
        event.target.xScale = 1
        event.target.yScale = 1
        event.target.x = event.target.xStart
        event.target.y = event.target.yStart
      end
    end
  end

  -- Important to return true. This tells the system that the event
  -- should not be propagated to listeners of any objects underneath.
  return true
end


local function creaNumeros()
  local offsetX = 100
  local startX = 250
  local idx = 1
  local y = 100
  local boxY = 300
  for i,val in pairs(reorderedNumbers) do
    local numeroDg = display.newGroup()
    local cuadro = display.newRect(i * offsetX + 50, y, 50, 50)
    cuadro:setFillColor(0.5, 0.6, 0.7)

    local numero = display.newText(val.value, 0, 0, native.systemFont, 40 )
    numero:setFillColor(1, 1, 1)

    numeroDg:insert(cuadro,true)
    numeroDg:insert(numero,true)

    if (i == 6) then
      y = 180
      idx = 1
    end

    numeroDg.x = idx * offsetX + 50 + startX
    numeroDg.y = y


    numeroDg.xStart = idx * offsetX + 50 + startX
    numeroDg.yStart = y
    numeroDg.arrPos = val

    numeroDg:addEventListener("touch", onTouch)

    table.insert(numeros, numeroDg)

    idx = idx + 1
  end
end

local function creaBoxes()
  local offsetX = 0
  local startX = 100
  local startY = 200
  local y = 120
  local idx = 1

  for i,val in pairs(reorderedNumbers) do
    local boxDg = display.newGroup()
    local box = display.newRect(0, 0, 100, 100)
    box:setFillColor(0.6, 0.7, 0.9)


    boxDg:insert(box, true)

    if (i == 5) then 
      offsetX = 330 
      startY = 200
      idx = 1
    elseif (i == 9) then
      startY = 200
      offsetX = 650
      idx = 1
    end

    local img = display.newImageRect("assets/ordenar.jpg", 200, 100)
    img:setStrokeColor(0, 0.9, 0.9)
    img.strokeWidth = 2
    img.x = offsetX + 250
    img.y = idx * y + startY

    boxDg.x = startX  + offsetX
    boxDg.y = y * idx + startY

    table.insert(boxes, boxDg)

    idx = idx + 1
--    y = y + 100
  end
end

local function shuffleTable( t )
  local rand = math.random 
  assert( t, "shuffleTable() expected a table, got nil" )
  local iterations = #t
  local j

  for i = iterations, 2, -1 do
    j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end

function invert( tableToInvert )
  local tabla = {}
  for k,v in pairs(tableToInvert) do
    local t = {}
    t.key = v
    t.value = k
    table.insert(tabla,t)
--    tabla[v] = t
  end
  return tabla
end


-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

  local sceneGroup = self.view

--  local fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
--  fondo:setFillColor(0.3, 0.5, 0.1)
  local fondo = display.newImageRect("assets/ordenar.jpg", display.contentWidth, display.contentHeight)
  fondo.x = display.contentCenterX
  fondo.y = display.contentCenterY
  reorderedNumbers = invert(setup.NUMBERS)
  reorderedNumbers = shuffleTable(reorderedNumbers)
--  reorderedNumbers = invert(reorderedNumbers)
  reorderedNumbers = shuffleTable(reorderedNumbers)
  creaNumeros()
  creaBoxes()
  sceneGroup:insert(fondo)
  for _,obj in pairs(numeros) do
    sceneGroup:insert(obj)
  end
  for _,obj in pairs(boxes) do
    sceneGroup:insert(obj)
  end

  -- Initialize the scene here
  -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen)
  elseif ( phase == "did" ) then
    -- Called when the scene is now on screen
    -- Insert code here to make the scene come alive
    -- Example: start timers, begin animation, play audio, etc.
  end
end


-- "scene:hide()"
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Called when the scene is on screen (but is about to go off screen)
    -- Insert code here to "pause" the scene
    -- Example: stop timers, stop animation, stop audio, etc.
  elseif ( phase == "did" ) then
    -- Called immediately after scene goes off screen
  end
end


-- "scene:destroy()"
function scene:destroy( event )

  local sceneGroup = self.view
  sceneGroup:removeSelf()

  -- Called prior to the removal of scene's view
  -- Insert code here to clean up the scene
  -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
