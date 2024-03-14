local C = require('Constants')
local composer = require("composer")

local scene = composer.newScene();

--criando a tela

function scene:create( event )
 
    local sceneGroup = self.view
--plano de fundo
local planofundo = display.newImage(sceneGroup,"Imagens\\gerais\\fundo.jpeg")
planofundo.x = display.contentCenterX
planofundo.y = display.contentCenterY

--nome do autor e livro
local planofundo = display.newImage(sceneGroup,"Imagens\\contra\\Rectangle 37.png")
planofundo.x = display.contentCenterX
planofundo.y = display.contentCenterY

--nome do autor e livro
    local planofundo = display.newImage(sceneGroup,"Imagens\\contra\\Group 84.png")
    planofundo.x = display.contentCenterX
    planofundo.y = display.contentCenterY

-- botão som
local btsom = display.newImage(
  sceneGroup, "Imagens\\gerais\\somd.png",
  C.W - 80 - C.MARGIN,
  C.H - 900 - C.MARGIN,
  50
)

-- botão inicio  
    local btNext = display.newImage(
      sceneGroup, "Imagens\\contra\\Group 57.png",
      C.W - 60 - C.MARGIN,
      C.H -1 - C.MARGIN,
      50
    )
    
  
    local btAnt = display.newImage(
	    sceneGroup, "Imagens\\gerais\\anterior.png",
	    C.W - 600 - C.MARGIN,
	    C.H - 1 - C.MARGIN,
	    50
    )	

    -- evento para ir para a proxima pagina
    function btNext.handle(event)
        composer.gotoScene("capa", {effect = "fromRight", time = 1000})
      end
    
      btNext:addEventListener('tap', btNext.handle)

      -- evento para ir para a proxima pagina
    function btAnt.handle(event)
        composer.gotoScene("tema6", {effect = "fromLeft", time = 1000})
        end

        btAnt:addEventListener('tap', btAnt.handle)

       -- Carregue o arquivo de áudio
  local backgroundMusic = audio.loadStream("audio/contra/ttsmaker-file-2024-3-4-1-11-9.mp3")

  --botão ligar e delisgar
  function btsom:touch(event)
	if event.phase == "began" then
		if isSoundOn then
		  audio.stop()
		  isSoundOn = false
		  display.newImage(sceneGroup,
		  "Imagens\\gerais\\somd.png",
		  C.W - 80 - C.MARGIN,
		  C.H - 900 - C.MARGIN,
		  50);
		  self.isVisible = false
		else
		  audio.play(backgroundMusic, { loops = -1 })
		  isSoundOn = true
		  display.newImage(sceneGroup,
		  "Imagens\\gerais\\soml.png",
		  C.W - 80 - C.MARGIN,
		  C.H - 900 - C.MARGIN,
		  50);
		  self.isVisible = true
		end
	end
	return true
  end  

btsom:addEventListener("touch", btsom)   
    
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
    sceneGroup:removeSelf()
    sceneGroup = nil
  
  end
  
  
  -- -----------------------------------------------------------------------------------
  -- Scene event function listeners
  -- -----------------------------------------------------------------------------------
  scene:addEventListener( "create", scene )
  scene:addEventListener( "show", scene )
  scene:addEventListener( "hide", scene )
  scene:addEventListener( "destroy", scene )
  -- -----------------------------------------------------------------------------------
  
  return scene