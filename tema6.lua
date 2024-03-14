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
    sceneGroup, "Imagens\\Tema6\\nome.png",
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
    sceneGroup, "Imagens\\Tema6\\botao.png",
    C.W - 340 - C.MARGIN,
    C.H - 735 - C.MARGIN,
    50
  )
   
-- Imagem de fundo do evento
local imag = display.newImage(
    sceneGroup, "Imagens\\Tema6\\fundo.png",
    C.W - 330 - C.MARGIN,
    C.H - 340 - C.MARGIN,
    50
  )

 ---- Personagem
 local p = display.newImage(
    sceneGroup, "Imagens\\Tema6\\indigenous 1.png",
    C.W - 100 - C.MARGIN,
    C.H - 600 - C.MARGIN,
    50
  )

 --- sol
 local sol = display.newImage(
    sceneGroup, "Imagens\\Tema6\\sun (1) 1.png",
    C.W - 140 - C.MARGIN,
    C.H - 410 - C.MARGIN,
    50
  )
  sol.isVisible = true
  
 --- terra
 local terra = display.newImage(
    sceneGroup, "Imagens\\Tema6\\soil (1) 1.png",
    C.W - 140 - C.MARGIN,
    C.H - 210 - C.MARGIN,
    50
  )
  terra.isVisible = true
 --- agua
 local agua = display.newImage(
    sceneGroup, "Imagens\\Tema6\\water-drop 1.png",
    C.W - 50 - C.MARGIN,
    C.H - 300 - C.MARGIN,
    50
  )
agua.isVisible = true
 --- semente
 local sem = display.newImage(
    sceneGroup, "Imagens\\Tema6\\sunflower-seed 1.png",
    C.W - 50 - C.MARGIN,
    C.H - 480 - C.MARGIN,
    200
  )
sem.isVisible = true

 ---pote
 local pote = display.newImage(
    sceneGroup, "Imagens\\Tema6\\vase 1.png",
    C.W - 100 - C.MARGIN,
    C.H - 90 - C.MARGIN,
    50
  )

 ---planta
 local planta = display.newImage(
    sceneGroup, "Imagens\\Tema6\\planta.png",
    C.W - 150 - C.MARGIN,
    C.H - 280 - C.MARGIN,
    50
  )
  planta.isVisible = false

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

  local isErasing = false

  local function trocarVisibilidade()
      terra.isVisible = not terra.isVisible
      sol.isVisible = not sol.isVisible
      agua.isVisible = not agua.isVisible
      sem.isVisible = not sem.isVisible
  end
  
  local function onCollision(event)
      if event.phase == "began" then
          -- Se a colisão começar com a imagem "p" e o toque estiver ocorrendo
          if event.object1 == p and p.isTouching then
              event.object2:removeSelf() -- Remova o objeto colidido (apagar)
          end
      end
  end
  
  -- Função para tratar eventos de toque no objeto "personagem que no caso é p"
  function p:touch(event)
      local phase = event.phase
  
      if phase == "began" then
          -- Define o foco no objeto "p"
          display.currentStage:setFocus(self)
          self.isFocus = true
  
          -- Armazena a posição inicial do toque
          self.startX = self.x
          self.startY = self.y
  
          -- Indica que o toque está em andamento
          self.isTouching = true
  
      elseif self.isFocus then
          if phase == "moved" then
              -- Calcula a nova posição do objeto
              local newX = event.x - event.xStart + self.startX
              local newY = event.y - event.yStart + self.startY
  
              -- Limita a posição do objeto dentro da tela
              newX = math.max(math.min(newX, C.W - 100), 130)
              newY = math.max(math.min(newY, C.H - 200), 310)
  
              -- Atualiza a posição do objeto
              self.x = newX
              self.y = newY
  
              -- Verifica colisões com outros objetos
              if terra.isVisible or sol.isVisible or agua.isVisible or sem.isVisible then
                  local boundsP = self.contentBounds
                  local boundsTerra = terra.contentBounds
                  local boundsSol = sol.contentBounds
                  local boundsAgua = agua.contentBounds
                  local boundsSem = sem.contentBounds
  
                  if verificarColisao(boundsP, boundsTerra) then
                      onCollision({ phase = "began", object1 = p, object2 = terra })
                  elseif verificarColisao(boundsP, boundsSol) then
                      onCollision({ phase = "began", object1 = p, object2 = sol })
                  elseif verificarColisao(boundsP, boundsAgua) then
                      onCollision({ phase = "began", object1 = p, object2 = agua })
                  elseif verificarColisao(boundsP, boundsSem) then
                      onCollision({ phase = "began", object1 = p, object2 = sem })
                  end
              end
  
          elseif phase == "ended" or phase == "cancelled" then
              -- Retira o foco do objeto "p"
              display.currentStage:setFocus(nil)
              self.isFocus = false
  
              -- Indica que o toque terminou
              self.isTouching = false
  
              -- Troca a visibilidade dos objetos
              trocarVisibilidade()
  
              -- Verificar colisão com o objeto "pote"
              local boundsP = self.contentBounds
              local boundsPote = pote.contentBounds
  
              if verificarColisao(boundsP, boundsPote) then
                  -- Se houver colisão, faça a imagem "p" desaparecer
                  self.isVisible = false
                  
                  -- Faça a imagem "planta" aparecer
                  planta.isVisible = true
              end
          end
          
      end
  
      return true
  end
  
  -- Função auxiliar para verificar colisões entre retângulos
  function verificarColisao(bounds1, bounds2)
      if bounds2 then
          return bounds1.xMin < bounds2.xMax and bounds1.xMax > bounds2.xMin and
                 bounds1.yMin < bounds2.yMax and bounds1.yMax > bounds2.yMin
      end
      return false
  end
  
  -- Adiciona o evento de toque ao objeto p
  p:addEventListener("touch", p)


-- Adicionar o evento de toque ao objeto "p"
p:addEventListener("touch", p)

-- evento para ir para a proxima pagina
  function btNext.handle(event)
    composer.gotoScene("contra", {effect = "fromRight", time = 1000})
  end

  btNext:addEventListener('tap', btNext.handle)

-- evento para ir para a proxima pagina
function btAnt.handle(event)
    composer.gotoScene("tema5", {effect = "fromLeft", time = 1000})
  end

  btAnt:addEventListener('tap', btAnt.handle)


  -- Carregue o arquivo de áudio
  local backgroundMusic = audio.loadStream("audio\\tema6\\mataAtlantica.mp3")

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