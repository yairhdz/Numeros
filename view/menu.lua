---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local widget   = require( "widget" )
local currentScene  = composer.getSceneName("current")
local scene = composer.newScene()

---------------------------------------------------------------------------------

local function buttonListener( event )
  local touchedButton = event.target.id
  composer.removeScene(currentScene)
  if ( touchedButton == "aprende" ) then
    composer.gotoScene("view.secuencia", { effect = "slideRight" } )
  elseif ( touchedButton == "ordena" ) then
    composer.gotoScene("view.ordenar", { effect = "slideRight" } )
  elseif ( touchedButton == "cuenta" ) then
    composer.gotoScene("view.contar", { effect = "slideRight" } )
  elseif ( touchedButton == "contacto" ) then
    composer.gotoScene("view.contacto", { effect = "fade"} )
  elseif ( touchedButton == "acercade" ) then
    composer.gotoScene("view.acercade", { effect = "fade"} )
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

  local contacto = display.newImage("assets/contacto.png", true)
  contacto.xScale = 0.4
  contacto.yScale = 0.4
  contacto.x = display.contentCenterX - 250
  contacto.y = display.contentCenterY + 250

  local contactoButton = display.newImage("assets/contacto_button.png")
  contactoButton.id = "contacto"
  contactoButton.xScale = 0.4
  contactoButton.yScale = 0.4
  contactoButton.x = display.contentCenterX - 265
  contactoButton.y = display.contentCenterY + 175
  contactoButton:addEventListener("touch", buttonListener)

  local acercaButton = display.newImage("assets/acercade_button.png")
  acercaButton.id = "acercade"
  acercaButton.xScale = 0.4
  acercaButton.yScale = 0.4
  acercaButton.x = display.contentCenterX - 237
  acercaButton.y = display.contentCenterY + 245
  acercaButton:addEventListener("touch", buttonListener)

  sceneGroup:insert(fondo)
  sceneGroup:insert(secuenciaButton)
  sceneGroup:insert(ordenarButton)
  sceneGroup:insert(contarButton)
  sceneGroup:insert(contacto)
  sceneGroup:insert(contactoButton)
  sceneGroup:insert(acercaButton)
end

function scene:show( event )
  local sceneGroup = self.view

end


function scene:destroy( event )
  local sceneGroup = self.view
  sceneGroup:removeSelf()

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
