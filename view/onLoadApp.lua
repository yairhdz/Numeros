---------------------------------------------------------------------------------
--
-- onLoad.lua
--
---------------------------------------------------------------------------------

local sceneName = "onLoadApp"

local composer = require( "composer" )
local widget   = require( "widget" )

-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------
local function buttonListener() 
  local options = {
    effect = "slideUp",
    time = 500,
    params = {
      sampleVar1 = "my sample variable",
      sampleVar2 = "another sample variable"
    }
  }

  timer.performWithDelay(500, function() composer.gotoScene("scene2", options) end)
end


function scene:create( event )
  local sceneGroup = self.view

  local loadImage = display.newImageRect(sceneGroup, "assets/load.jpg", display.contentWidth, display.contentHeight)
  loadImage.x = display.contentCenterX
  loadImage.y = display.contentCenterY

  local playButton = widget.newButton(
    {
      label = "Jugar",
      defaultFile = "assets/play_button.png",
      overFile = "assets/play_button_hover.png",
      label = "button",
      onEvent = buttonListener
    }
  )
  playButton.x = display.contentCenterX + 120
  playButton.y = display.contentCenterY + 450

  sceneGroup:insert(playButton)

  -- Called when the scene's view does not exist
  -- 
  -- INSERT code here to initialize the scene
  -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
  local sceneGroup = self.view

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
