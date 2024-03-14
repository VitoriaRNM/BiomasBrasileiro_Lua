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
  bg:setFillColor(0.18,0.54,0.34)
  
--Nome do Tema
local nome = display.newImage(
    sceneGroup, "Imagens\\Tema4\\Group 85.png",
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
    sceneGroup, "Imagens\\Tema4\\Group 86.png",
    C.W - 335 - C.MARGIN,
    C.H - 720 - C.MARGIN,
    50
  )

-- Imagem de fundo do evento
local fundo = display.newImage(
    sceneGroup, "Imagens\\Tema4\\Group 87.png",
    C.W - 330 - C.MARGIN,
    C.H - 340 - C.MARGIN,
    50
  )

 -- cartão geral
 local imag = display.newImage(
  sceneGroup, "Imagens\\Tema4\\card.png",
  C.W - 330 - C.MARGIN,
  C.H - 340 - C.MARGIN,
  50
) 

local imag1 = display.newImage(
  sceneGroup, "Imagens\\Tema4\\card.png",
  C.W - 120 - C.MARGIN,
  C.H - 148 - C.MARGIN,
  50
) 

local imag2 = display.newImage(
  sceneGroup, "Imagens\\Tema4\\card.png",
  C.W - 530 - C.MARGIN,
  C.H - 148 - C.MARGIN,
  50
)

local card1 = display.newImage(
  sceneGroup, "Imagens\\Tema4\\cardClima.png"
)
card1.isVisible = false
card1.x = display.contentCenterX
card1.y = display.contentCenterY + 110


local card2 = display.newImage(
  sceneGroup, "Imagens\\Tema4\\cardFauna.png"
)
card2.isVisible = false
card2.x = display.contentCenterX
card2.y = display.contentCenterY + 110

local card3 = display.newImage(
  sceneGroup, "Imagens\\Tema4\\cardFlora.png"
)
card3.isVisible = false
card3.x = display.contentCenterX
card3.y = display.contentCenterY + 110


-- botão proximo  
local btNext = display.newImage(
    sceneGroup, "Imagens\\gerais\\proximo.png",
    C.W - 50 - C.MARGIN,
    C.H + 1 - C.MARGIN,
    50
  )
-- botão anterior
local btAnt = display.newImage(
	sceneGroup, "Imagens\\gerais\\anterior.png",
	C.W - 610 - C.MARGIN,
	C.H + 1 - C.MARGIN,
	50
  )	
  
-- evento para ir para a proxima pagina
  function btNext.handle(event)
    composer.gotoScene("tema5", {effect = "fromRight", time = 1000})
  end

  btNext:addEventListener('tap', btNext.handle)
  
-- evento para ir para a proxima pagina
function btAnt.handle(event)
    composer.gotoScene("tema3", {effect = "fromLeft", time = 1000})
  end

  btAnt:addEventListener('tap', btAnt.handle)

  -- Carregue o arquivo de áudio
  local backgroundMusic = audio.loadStream("audio\\tema4\\caatinga.mp3")
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
  
--card1
  function imag:tap(event)
    -- Aqui você pode adicionar a lógica para mostrar o card1
    card1.isVisible = true
  end
  
  imag:addEventListener('tap', imag)
  
  function card1:tap(event)
    -- Aqui você pode adicionar a lógica para mostrar o card1
    card1.isVisible = false
  end
  
  card1:addEventListener('tap', card1)

  --card 2
  function imag1:tap(event)
    -- Aqui você pode adicionar a lógica para mostrar o card1
    card2.isVisible = true
  end
  
  imag1:addEventListener('tap', imag1)
  
  function card2:tap(event)
    -- Aqui você pode adicionar a lógica para mostrar o card1
    card2.isVisible = false
  end
  
  card2:addEventListener('tap', card2)

  --card 3
  function imag2:tap(event)
    -- Aqui você pode adicionar a lógica para mostrar o card1
    card3.isVisible = true
  end
  
  imag2:addEventListener('tap', imag2)
  
  function card3:tap(event)
    -- Aqui você pode adicionar a lógica para mostrar o card1
    card3.isVisible = false
  end
  
  card3:addEventListener('tap', card3)


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