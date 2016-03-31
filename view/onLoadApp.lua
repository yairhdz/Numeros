---------------------------------------------------------------------------------
--
-- onLoad.lua
--
---------------------------------------------------------------------------------

local sceneName = "onLoadApp"

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------

function scene:create( event )
  local sceneGroup = self.view
  local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
  background:setFillColor(0.5,0.6,0.7)

  local loadImage = display.newCircle(display.contentCenterX, display.contentCenterY, 50)
  loadImage:setFillColor(0.6,0.2,0.4)

  sceneGroup:insert(background)
  sceneGroup:insert(loadImage)
  --loadImage.x = 100
--    loadImage.y = 100

  -- Called when the scene's view does not exist
  -- 
  -- INSERT code here to initialize the scene
  -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
  local sceneGroup = self.view


  local options = {
    effect = "fade",
    time = 400,
    params = {
      sampleVar1 = "my sample variable",
      sampleVar2 = "another sample variable"
    }
  }

  timer.performWithDelay(1000, function() composer.gotoScene("scene2", options) end)
  print("CAMBIE A scene2")

end

function scene:hide( event )
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
