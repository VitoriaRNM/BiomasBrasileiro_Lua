
  local C = require('Constants')
  local composer = require("composer")
  display.setDefault("magTextureFilter", "nearest")
  
  local scene = composer.newScene()
  
  -- Criação da tela
  function scene:create(event)
      local sceneGroup = self.view
  
      -- Plano de fundo
      local planofundo = display.newImage(sceneGroup, "Imagens\\gerais\\fundo.jpeg")
      planofundo.x = display.contentCenterX
      planofundo.y = display.contentCenterY
  
      -- Nome do autor e do livro
      local nomeAutorLivro = display.newImage(sceneGroup, "Imagens\\capa\\Group 2.png")
      nomeAutorLivro.x = display.contentCenterX
      nomeAutorLivro.y = display.contentCenterY
  
      -- Botão som
      local btsom = display.newImage(
          sceneGroup,
          "Imagens\\gerais\\somd.png",
          C.W - 80 - C.MARGIN,
          C.H - 900 - C.MARGIN,
          50
      )
  
      -- Botão próximo
      local btNext = display.newImage(
          sceneGroup, "Imagens\\gerais\\proximo.png",
          C.W - 50 - C.MARGIN,
          C.H - 50 - C.MARGIN,
          50
      )
  
      -- Carregue o arquivo de áudio
      local backgroundMusic = audio.loadStream("audio/capa/ttsmaker-file-2024-3-4-14-36-40.mp3")

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
  
      function btNext.handle(event)
          composer.gotoScene("intro", { effect = "fromRight", time = 1000 })
      end
  
      btNext:addEventListener('tap', btNext.handle)
  end
  
  -- Funções de show, hide e destroy
  
  scene:addEventListener("create", scene)
  scene:addEventListener("show", scene)
  scene:addEventListener("hide", scene)
  scene:addEventListener("destroy", scene)
  
  return scene
 