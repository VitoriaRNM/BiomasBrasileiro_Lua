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
    sceneGroup, "Imagens\\Tema5\\Group 91.png",
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
    sceneGroup, "Imagens\\Tema5\\balão.png",
    C.W - 320 - C.MARGIN,
    C.H - 740 - C.MARGIN,
    50
  )
   
-- Imagem de fundo do evento
local imag = display.newImage(
    sceneGroup, "Imagens\\Tema5\\conteudo.png",
    C.W - 330 - C.MARGIN,
    C.H - 340 - C.MARGIN,
    50
  )
--linha
  local linha = display.newLine(
    sceneGroup, 
    display.contentCenterX -650, 
    840, --tamanho da linha, 
    display.contentCenterX, 
    840
  )
  linha.strokeWidth = 8,
  linha:setStrokeColor(0, 0.35, 0.5)
  linha.x = display.contentCenterX - 300
  linha.y = display.contentCenterY - 200  

 --marcador
 local marcador = display.newImage(
    sceneGroup, "Imagens\\Tema5\\mark 1.png",
    C.W -340 - C.MARGIN,
    C.H - 670 - C.MARGIN,
    50
  )
-- Imagem calor
local calor = display.newImage(
    sceneGroup, "Imagens\\Tema5\\calor.png",
    C.W - 650 - C.MARGIN,
    C.H - 670 - C.MARGIN,
    50
  )
  -- Imagem frio
local frio = display.newImage(
  sceneGroup, "Imagens\\Tema5\\frio.png",
  C.W - 20 - C.MARGIN,
  C.H - 670 - C.MARGIN,
  50
)

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
    composer.gotoScene("tema6", {effect = "fromRight", time = 1000})
  end

  btNext:addEventListener('tap', btNext.handle)

-- evento para ir para a proxima pagina
function btAnt.handle(event)
    composer.gotoScene("tema4", {effect = "fromLeft", time = 1000})
  end

  btAnt:addEventListener('tap', btAnt.handle)

-- evento do marcador
local limiteDireita = C.W - 450


function marcador:touch(event)
  local phase = event.phase

  if (phase == "began") then
      display.currentStage:setFocus(self)
      self.isFocus = true
      self.startX = self.x
      self.startY = self.y

  elseif (self.isFocus) then
      if (phase == "moved") then
          local newX = event.x - event.xStart + self.startX
          local newY = event.y - event.yStart + self.startY

          -- Aplicar limites aos lados
          newX = math.max(math.min(newX, C.W - 130), 130)  -- Limita entre 50 e largura da tela - 50
          newY = math.max(math.min(newY, C.H - 715), 310)  -- Limita entre 50 e altura da tela - 50

          self.x = newX
          self.y = newY    

      elseif (phase == "ended" or phase == "cancelled") then
          display.currentStage:setFocus(nil)
          self.isFocus = false

          local newX = self.x

          -- Verificar se o marcador ultrapassou o limite
          if (newX > limiteDireita) then
              -- Alterar a imagem quando desliza para a direita
              
              imag = display.newImage(
                  sceneGroup, "Imagens\\Tema5\\g1.png",
                  C.W - 335 - C.MARGIN,
                  C.H - 325 - C.MARGIN,
                  50
              )
          elseif (newX < limiteDireita) then
              -- Alterar a imagem quando desliza para a esquerda
              imag = display.newImage(
                  sceneGroup, "Imagens\\Tema5\\quente.png",
                  C.W - 335 - C.MARGIN,
                  C.H - 280 - C.MARGIN,
                  50
              )
          end
      end
  end

  return true
end

    marcador:addEventListener("touch", marcador)
 -- Carregue o arquivo de áudio
 local backgroundMusic = audio.loadStream("audio\\tema5\\pampas.mp3")

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