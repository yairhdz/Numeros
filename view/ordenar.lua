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


-- -----------------------------------------------------------------------------------------------------------------
-- Local forward references should go local function creaNumeros() 
local function creaNumeros()
  local offsetX = 100
  local x = 0
  local y = 100
  for i,val in pairs(reorderedNumbers) do
    local numeroDg = display.newGroup()
    local cuadro = display.newRect(x * offsetX + 50, y, 50, 50)
    cuadro:setFillColor(0.5, 0.6, 0.7)

    local numero = display.newText(val.value, i * offsetX + 50, y, native.systemFont, 40 )
    numero:setFillColor(1, 1, 1)

    numeroDg:insert(cuadro,true)
    numeroDg:insert(numero,true)

    numeroDg.x = x * offsetX + 50
    numeroDg.y = y

    numeroDg.xStart = i * offsetX + 50
    numeroDg.yStart = y
    numeroDg.arrPos = i
    x = x + 1

    table.insert(numeros, numeroDg)
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

local function invert()
  local tabla = {}
  for k,v in pairs(reorderedNumbers) do
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

  local fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
  fondo:setFillColor(0.3, 0.5, 0.1)
  reorderedNumbers = shuffleTable(setup.NUMBERS)
  reorderedNumbers = invert()
  reorderedNumbers = shuffleTable(reorderedNumbers)
  creaNumeros()

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