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
  local fondo = display.newImageRect("assets/contacto3.jpg", display.contentWidth, display.contentHeight)
  fondo.x = display.contentCenterX
  fondo.y = display.contentCenterY
  mainView:insert(fondo)

  local buzon= display.newImageRect("assets/buzon.png",350,450)
  buzon.x = 710
  buzon.y=display.contentCenterY
  mainView:insert(buzon)


  local cuadro = display.newRoundedRect(330,display.contentCenterY,400,500,30)
  cuadro:setFillColor(0,0.9,0.9)
  cuadro.alpha=0.2
  cuadro.strokeWidth=15
  cuadro:setStrokeColor(0,0,0)
  mainView:insert(cuadro)

  local title = display.newText({
      text = "Ponte en contacto con nosotros:",
      x=330,
      y=160,
      font=native.systemFontBold,
      fontSize= 23})
  title:setFillColor(0,0.5,0.9)
  mainView:insert(title)


  local name1 = display.newText({
      text = "Ángel Giovanni Álvarez Castro",
      x=330,
      y=220,
      font=native.systemFontBold,
      fontSize=20})
  name1:setFillColor(0.6, 0.4, 0.8)
  mainView:insert(name1)

  local correo1 = display.newText({
      text = "Email: angelgiovanni@hotmail.com",
      x=330,
      y=245,
      font=native.systemFontBold,
      fontSize=20})
  correo1:setFillColor(0.6, 0.4, 0.8)
  mainView:insert(correo1)

  local name2 = display.newText({
      text = "Lourdes Stephanie Moreno Domínguez",
      x=330,
      y=305,
      font=native.systemFontBold,
      fontSize=20})
  name2:setFillColor(0.6, 0.4, 0.8)
  mainView:insert(name2)

  local correo2 = display.newText({
      text = "Email: lsthepaniemd@hotmail.com",
      x=330,
      y=330,
      font=native.systemFontBold,
      fontSize=20})
  correo2:setFillColor(0.6, 0.4, 0.8)
  mainView:insert(correo2)

  local name3 = display.newText({
      text = "Jessica Josefina Gómez Mejía",
      x=330,
      y=390,
      font=native.systemFontBold,
      fontSize=20})
  name3:setFillColor(0.6, 0.4, 0.8 )
  mainView:insert(name3)

  local correo3 = display.newText({
      text = "Email: jessmejia@hotmail.com",
      x=330,
      y=415,
      font=native.systemFontBold,
      fontSize=20})
  correo3:setFillColor(0.6, 0.4, 0.8)
  mainView:insert(correo3)

  local name4 = display.newText({
      text = "Jesica Yuritze Reynada Ortiz",
      x=330,
      y=475,
      font=native.systemFontBold,
      fontSize=20})
  name4:setFillColor(0.6,0.4,0.8)
  mainView:insert(name4)

  local correo4 = display.newText({
      text="Email: jesicareynada@hotmail.com",
      x=330,
      y=500,
      font=native.systemFontBold,
      fontSize=20})
  correo4:setFillColor(0.6,0.4,0.8)
  mainView:insert(correo4)

  local name5 = display.newText({
      text="Yair Hernández García",
      x=330,
      y=560,
      font=native.systemFontBold,
      fontSize=20})
  name5:setFillColor(0.6,0.4,0.8)
  mainView:insert(name5)

  local correo5 = display.newText({
      text="Email: yair_angie@hotmail.com",
      x=330,
      y=585,
      font=native.systemFontBold,
      fontSize=20})
  correo5:setFillColor(0.6,0.4,0.8)
  mainView:insert(correo5)

  local button1 = widget.newButton(
    {
      width = 100,
      height = 100,
      defaultFile = "assets/regresar.png",
      overFile = "assets/regresar.png",
      x=615,
      y=600,
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