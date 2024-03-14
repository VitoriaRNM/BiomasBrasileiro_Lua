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
    sceneGroup, "Imagens\\Tema1\\Group 70.png",
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
    sceneGroup, "Imagens\\Tema1\\Group 77.png",
    C.W - 300 - C.MARGIN,
    C.H - 740 - C.MARGIN,
    50
  )
   
-- Imagem de fundo do evento
local imag = display.newImage(
    sceneGroup, "Imagens\\Tema1\\Group 76.png",
    C.W - 330 - C.MARGIN,
    C.H - 340 - C.MARGIN,
    50
  )


  physics.start()
  physics.setGravity(0, 9.8)

--chuva
local numChuva = 100
    local chuva = {}

    for i = 1, numChuva do
        chuva[i] = display.newImage(
            sceneGroup,
            "Imagens\\Tema1\\chuva.png",
            math.random(C.MARGIN, C.W - C.MARGIN),
            math.random(C.MARGIN, C.H - 650 - C.MARGIN),
            50
        )
        physics.addBody(chuva[i], 'dynamic')
        chuva[i].linearDamping = i % 2 == 0 and 2.5 or 1
        chuva[i].isVisible = false
    end

local linhalimite = display.newLine(sceneGroup, display.contentCenterX - 650, 840, display.contentCenterX, 840)
    linhalimite.strokeWidth = 2
    linhalimite:setStrokeColor(1, 0, 0)
    linhalimite.x = display.contentCenterX - 300
    linhalimite.y = display.contentCenterY + 900
    physics.addBody(linhalimite, "static", { friction = 0.5, bounce = 0.3 })---

    --nuvens
local nuvem = display.newImage(
    sceneGroup, "Imagens\\Tema1\\nuvem.png",
    C.W - 320 - C.MARGIN,
    C.H - 650 - C.MARGIN,
    50
   );
 nuvem.isVisible = false  

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
    composer.gotoScene("tema2", {effect = "fromRight", time = 1000})
  end

  btNext:addEventListener('tap', btNext.handle)

-- evento para ir para a proxima pagina
function btAnt.handle(event)
    composer.gotoScene("intro", {effect = "fromLeft", time = 1000})
  end

  btAnt:addEventListener('tap', btAnt.handle)

 -- Adiciona um atraso de 2 segundos antes de mostrar as nuvens
 timer.performWithDelay(2000, function()
    nuvem.isVisible = true
end) 

 timer.performWithDelay(2500, function()
    for i = 1, numChuva do
        chuva[i].isVisible = true
    end
end)


  -- Carregue o arquivo de áudio
  local backgroundMusic = audio.loadStream("audio\\tema1\\amazonia.mp3")

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