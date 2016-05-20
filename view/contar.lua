local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here
local path = "assets/contar/"
local escenarios = {
                    {imagen = "escenario2.png", contenido = {{objeto= "elefantes", cantidad = "1"}, {objeto= "jirafas", cantidad = "2"}, {objeto= "leones", cantidad = "3"}, {objeto= "tigres", cantidad = "4"}}},
                    {imagen = "escenario3.png", contenido = {{objeto= "perros", cantidad = "5"}, {objeto= "gatos", cantidad = "6"}}}
                   }
                   
local tiempoTransicion = 3000                   
local escenarioActual = 1  
local preguntaActual = 1
local allObjects = {}
local preguntaAnterior = nil

-- -------------------------------------------------------------------------------

--
--
--
local function scrollListener( event )
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end

    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached top limit" )
        elseif ( event.direction == "down" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "left" ) then print( "Reached left limit" )
        elseif ( event.direction == "right" ) then print( "Reached right limit" )
        end
    end
    return true
end


--
--
--
local function creaScrollView(imagen)
  local scrollView = widget.newScrollView
  {
      top = 50,
      left = 10,
      width = 1000,
      height = 600,
      scrollWidth = 5000,
      scrollHeight = 800,
      verticalScrollDisabled = true,
      listener = scrollListener,
  }
  
  imagen.anchorY = 0
  imagen.anchorX = imagen.width
  scrollView:insert( imagen )
  table.insert(allObjects, scrollView)

  timer.performWithDelay(1000, function()transition.to(imagen, {anchorX = 0.0, time = tiempoTransicion} )end)
end



--
--
--
local function mostrarPreguntas(obj)
  if(preguntaAnterior) then
    preguntaAnterior:removeSelf()
  end
  local pregunta = display.newText("¿Cuantos(as) " .. obj .. " hay?", 250,700, nil, 30)
  preguntaAnterior = pregunta
  siguientePregunta.isVisible = false
  local respuesta = ""

  local function textListener( event )
    if ( event.phase == "editing" ) then
      respuesta = event.text
      print( event.newCharacters )
      print( event.text )
      if(escenarioActual <= #escenarios) then
        if(respuesta == escenarios[escenarioActual].contenido[preguntaActual].cantidad) then
          siguientePregunta.isVisible = true
          preguntaAnterior.isSolved = true
        else
          siguientePregunta.isVisible = false
        end
      end
    end
  end

  local textField = native.newTextField( 550, 700, 100, 30 )
  textField.inputType = "number"
  table.insert(allObjects, textField)
  textField:addEventListener( "userInput", textListener )
end


--
--
--
local function cargaImagen(escenario)
  local nombreImagen = escenario.imagen
  local imagen = display.newImage(path .. nombreImagen, true)
  return imagen
end


--
--
--
local function iniciaJuego()
  local imagen= cargaImagen(escenarios[escenarioActual])
  if (imagen) then
    creaScrollView(imagen)
    timer.performWithDelay(tiempoTransicion + 1000, function()mostrarPreguntas(escenarios[escenarioActual].contenido[preguntaActual]. objeto)end,1)
    table.insert(allObjects, imagen)
  end
end


--
--
--
local function siguienteEjercicioListener(event)
  if (event.phase == "ended") then
    escenarioActual = escenarioActual + 1
    if (escenarioActual <= #escenarios) then
      print("siguiente ejercicio")
      preguntaAnterior:removeSelf()
      preguntaAnterior = nil
      
      for i=1, #allObjects do
        allObjects[i]:removeSelf()
      end
      allObjects = {}
      
      preguntaActual = 1
      siguientePregunta.isVisible = false
      siguienteEjercicio.isVisible = false
      iniciaJuego()
    else
      print("no hay mas escenarios")
      --siguienteEjercicio.isVisible = false
      native.showAlert("Felicidades", "Te felicito has terminado todos los ejercicios", {"OK"})
    end
  end
end

--
--
--
local function siguientePreguntaListener(event)
  if (event.phase == "ended") then
    if (preguntaAnterior.isSolved) then
      preguntaActual = preguntaActual + 1
      if (preguntaActual <= #escenarios[escenarioActual].contenido) then
        print("siguiente pregunta")
        mostrarPreguntas(escenarios[escenarioActual].contenido[preguntaActual].objeto)
      else
        print("No hay mas preguntas")
        siguientePregunta.isVisible = false
        siguienteEjercicio.isVisible = true
      end
    end
  end
end




-- "scene:create()"
function scene:create( event )
  
  local fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentWidth)
  fondo:setFillColor(0.1, 0.3, 0.5)
    
  siguientePregunta = display.newCircle(800,700,20)
  siguientePregunta:setFillColor(0.8, 0.1,0)
  siguientePregunta.isVisible = false
  siguientePregunta:addEventListener("touch", siguientePreguntaListener)
    
  siguienteEjercicio = display.newCircle(800,700,20)
  siguienteEjercicio.isVisible = false
  siguienteEjercicio:addEventListener("touch", siguienteEjercicioListener)
    
  iniciaJuego()
  
  local sceneGroup = self.view
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
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
