local C = require('Constants')
local composer = require("composer")
local physics =  require("physics")

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
  bg:setFillColor(0.18,0.54,0.34)
--Nome do Tema
local nome = display.newImage(
    sceneGroup, "Imagens\\Tema2\\nome.png",
    C.W - 332 - C.MARGIN,
    C.H - 900 - C.MARGIN,
    50
  )

-- botão som
local btsom = display.newImage(
  sceneGroup, "Imagens\\gerais\\somd.png",
  C.W - 70 - C.MARGIN,
  C.H - 810 - C.MARGIN,
  50
)

--balão de conversa
local balao = display.newImage(
    sceneGroup, "Imagens\\Tema2\\balao.png",
    C.W - 328 - C.MARGIN,
    C.H - 710 - C.MARGIN,
    50
  )
   
-- segunda Imagem de fundo do evento
local imag = display.newImage(
    sceneGroup, "Imagens\\Tema2\\imag1.png",
    C.W - 330 - C.MARGIN,
    C.H - 325 - C.MARGIN,
    50
  )

  -- Imagem de fundo do evento
local imagem2 = display.newImage(
    sceneGroup, "Imagens\\Tema2\\fundo1.png",
    C.W - 330 - C.MARGIN,
    C.H - 330 - C.MARGIN,
    50
  )

-- botão proximo  
local btNext = display.newImage(
    sceneGroup, "Imagens\\gerais\\proximo.png",
    C.W - 50 - C.MARGIN,
    C.H + 10 - C.MARGIN,
    50
  )
-- botão anterior
local btAnt = display.newImage(
	sceneGroup, "Imagens\\gerais\\anterior.png",
	C.W - 610 - C.MARGIN,
	C.H + 10 - C.MARGIN,
	50
  )	
  
-- evento para ir para a proxima pagina
  function btNext.handle(event)
    composer.gotoScene("tema3", {effect = "fromRight", time = 1000})
  end

  btNext:addEventListener('tap', btNext.handle)

-- evento para ir para a proxima pagina
function btAnt.handle(event)
    composer.gotoScene("tema1", {effect = "fromLeft", time = 1000})
  end

  btAnt:addEventListener('tap', btAnt.handle)


  -- Carregue o arquivo de áudio
  local backgroundMusic = audio.loadStream("audio\\tema2\\cerrado.mp3")

  --botão ligar e delisgar
  function btsom:touch(event)
	if event.phase == "began" then
		if isSoundOn then
		  audio.stop()
		  isSoundOn = false
		  display.newImage(sceneGroup,
		  "Imagens\\gerais\\somd.png",
		  C.W - 70 - C.MARGIN,
		  C.H - 810 - C.MARGIN,
		  50);
		  self.isVisible = false
		else
		  audio.play(backgroundMusic, { loops = -1 })
		  isSoundOn = true
		  display.newImage(sceneGroup,
		  "Imagens\\gerais\\soml.png",
		  C.W - 70 - C.MARGIN,
		  C.H - 810 - C.MARGIN,
		  50);
		  self.isVisible = true
		end
	end
	return true
  end  

btsom:addEventListener("touch", btsom)

function imag:touch(event)
    local self = event.target  -- Para referenciar a própria imagem
    if event.phase == "began" and event.isSecondaryTouch then
        -- Verifique se dois dedos estão tocando simultaneamente na imagem1
        if event.numTouches == 2 then
            trocarVisibilidade()
        end
    end
    return true
end

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