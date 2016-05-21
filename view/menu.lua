---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local widget   = require( "widget" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------

local function buttonListener( event )
  print("TOUCHED".. event.target:getLabel())
  local touchedButton = event.target.id
  if ( touchedButton == "aprende" ) then
    composer.gotoScene("view.secuencia", { effect = "slideRight" } )
  elseif ( touchedButton == "ordena" ) then
    composer.gotoScene("view.ordenar", { effect = "slideRight" } )
  elseif ( touchedButton == "cuenta" ) then
    composer.gotoScene("view.contar", { effect = "slideRight" } )
  end
end

function scene:create( event )
  local sceneGroup = self.view
  -- Called when the scene's view does not exist
  -- 
  -- INSERT code here to initialize the scene
  -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
  local centerX = display.contentCenterX
  local centerY = display.contentCenterY
--  local fondo = display.newRect(centerX, centerY, display.actualContentWidth, display.contentHeight)
  local fondo = display.newImageRect("assets/menu.png", display.contentWidth, display.contentHeight)
  fondo.x = centerX
  fondo.y = centerY
  local secuenciaButton = widget.newButton(
    {
      defaultFile = "assets/controls/aprende_button.png",
      width = 370, 
      height = 66,
      x = centerX + 160,
      y = centerY - 10,
      onEvent = buttonListener
    }
  )
  secuenciaButton.id = "aprende"

  local ordenarButton = widget.newButton(
    {
      defaultFile = "assets/controls/ordenar_button.png",
--      overFile = "assets/play_button_hover.png",
      width = 370, 
      height = 66,
      x = centerX + 160,
      y = centerY + 65,
      onEvent = buttonListener
    }
  )
  ordenarButton.id = "ordena"

  local contarButton = widget.newButton(
    {
      defaultFile = "assets/controls/contar_button.png",
      width = 370, 
      height = 66,
      x = centerX + 160,
      y = centerY + 145,
      onEvent = buttonListener
    }
  )
  contarButton.id = "cuenta"

  sceneGroup:insert(fondo)
  sceneGroup:insert(secuenciaButton)
  sceneGroup:insert(ordenarButton)
  sceneGroup:insert(contarButton)
end

function scene:show( event )
  local sceneGroup = self.view

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
