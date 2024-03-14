local C = require('Constants')
local composer = require("composer")

local scene = composer.newScene();

function scene:create( event )

 
local sceneGroup = self.view

--- Blackgroud de fundo
local bg = display.newRect(
	sceneGroup,
	C.CW,
	C.CH,
	C.W,
	C.H
  )
  bg:setFillColor(0.47,0.76,0.47)

---Informações da introdução
local planofundo = display.newImage(sceneGroup,"Imagens\\Intoducao\\Group 55.png")
    planofundo.x = display.contentCenterX
    planofundo.y = display.contentCenterY


-- botão som
local btsom = display.newImage(
  sceneGroup, "Imagens\\gerais\\somd.png",
  C.W - 70 - C.MARGIN,
  C.H - 780 - C.MARGIN,
  50
)

-- botão proximo  
local btNext = display.newImage(
    sceneGroup, "Imagens\\gerais\\proximo.png",
    C.W - 60 - C.MARGIN,
    C.H + 1 - C.MARGIN,
    50
    )

	-- botão anterior 
local btAnt = display.newImage(
	sceneGroup, "Imagens\\gerais\\anterior.png",
	C.W - 600 - C.MARGIN,
	C.H + 1 - C.MARGIN,
	50
  )	

  -- evento para ir para a proxima pagina
  function btNext.handle(event)
	composer.gotoScene("tema1", {effect = "fromRight", time = 1000})
  end

  btNext:addEventListener('tap', btNext.handle)	

-- evento para ir para a  pagina anterior
function btAnt.handle(event)
    composer.gotoScene("capa", {effect = "fromLeft", time = 1000})
  end

  btAnt:addEventListener('tap', btAnt.handle)

  -- Carregue o arquivo de áudio
  local backgroundMusic = audio.loadStream("audio/intro/ttsmaker-file-2024-3-3-23-24-16.mp3")

  --botão ligar e delisgar
  function btsom:touch(event)
	if event.phase == "began" then
		if isSoundOn then
		  audio.stop()
		  isSoundOn = false
		  display.newImage(sceneGroup,
		  "Imagens\\gerais\\somd.png",
		  C.W - 70 - C.MARGIN,
		  C.H - 780 - C.MARGIN,
		  50);
		  self.isVisible = false
		else
		  audio.play(backgroundMusic, { loops = -1 })
		  isSoundOn = true
		  display.newImage(sceneGroup,
		  "Imagens\\gerais\\soml.png",
		  C.W - 70 - C.MARGIN,
		  C.H - 780 - C.MARGIN,
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
  

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
