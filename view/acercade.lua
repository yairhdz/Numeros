local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()
local mainView = display.newGroup()
local currentScene = composer.getSceneName("current") 


local function handleButtonEvent( event )
  if ( "ended" == event.phase ) then
    composer.removeScene(currentScene)
    composer.gotoScene("view.menu", {effect = "fade"}) 
  end
end

local function createView()
  local fondo = display.newImageRect("assets/fondo14.jpeg",display.contentWidth,display.contentHeight)
  fondo.x = display.contentCenterX
  fondo.y = display.contentCenterY
  mainView:insert(fondo)

  local logoIpn = display.newImageRect("assets/Logo_IPN.png",300,300)
  logoIpn.x=850
  logoIpn.y=470
  mainView:insert(logoIpn)

  local logoUpiicsa = display.newImageRect("assets/Logo_UPIICSA.png",150,150)
  logoUpiicsa.x =610
  logoUpiicsa.y=590
  mainView:insert(logoUpiicsa)

  local datos1 = display.newText({
      text = "INSTITUTO POLITECNICO NACIONAL",
      x=510,
      y=150,
      font = native.systemFontBold,
      fontSize= 50})
  datos1:setFillColor(0,0,0)
  mainView:insert(datos1)

  local datos2 = display.newText({
      text="UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA",
      x=510,
      y=250,
      font = native.systemFontBold,
      fontSize= 32})
  datos2:setFillColor(0,0,0)
  mainView:insert(datos2)

  local datos2cont= display.newText({
      text="Y CIENCIAS SOCIALES Y ADMINISTRATIVAS",
      x=510,
      y=300,
      font=native.systemFontBold,
      fontSize=32})
  datos2cont:setFillColor(0,0,0)
  mainView:insert(datos2cont)

  local datos3 = display.newText({
      text = "PROYECTO DE TITULACIÓN",
      x=300,
      y=460,
      font = native.systemFontBold,
      fontSize=40})
  datos3:setFillColor(0,0,0)
  mainView:insert(datos3)

  local datos4 =  display.newText({text="5NM81",
      x=300,
      y=650,
      font=native.systemFontBold,
      fontSize=40})
  datos4:setFillColor(0,0,0)
  mainView:insert(datos4)

  local button1 = widget.newButton(
    {
      width = 100,
      height = 100,
      defaultFile = "assets/regresar.png",
      overFile = "assets/regresar.png",
      x=100,
      y=700,
      onEvent = handleButtonEvent
    })
  mainView:insert(button1)
end

-- -----------------------------------------------------------------------------
-- Scene functions
-- -----------------------------------------------------------------------------

-- create()
function scene:create( event )

  local sceneGroup = self.view
  createView()

end


-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen

  end
end


-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)

  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen

  end
end


-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view
  mainView:removeSelf()

end


-- -----------------------------------------------------------------------------
-- Scene function listeners
-- -----------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------

return scene
