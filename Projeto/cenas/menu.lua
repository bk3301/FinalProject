-- COMPOSER
local composer = require('composer')

-- CENA
local cena = composer.newScene()

-- CRIANDO CENA MENU
function cena:create( event )
    local cenaMenu = self.view

    -- VARIAVEIS DE POSICIONAMENTO
    local x = display.contentWidth
	  local y = display.contentHeight

  -- MUSICA
  local musicaMenu = audio.loadStream('recursos/audios/musicaMenu.mp3')
  
  audio.play( musicaMenu, {channel = 32, loop = 0} )
  audio.setVolume( 0.5, {chennel = 32})
  audio.stop({channel = 31})

	-- DECLARACAO DA FONTE
    local fonte = native.newFont( 'recursos/fontes/fonte.ttf')

  -- FUNDO
    local fundo = display.newImageRect(cenaMenu, 'recursos/imagens/fundoMenu.png', x, y)
    fundo.x = x*0.5
    fundo.y = y*0.5
  
    -- ELEMENTOS DO MENU
    local logo = display.newImageRect(cenaMenu, 'recursos/imagens/logo.png', x*0.4, y*0.6)
    logo.x = x*0.5
    logo.y = y*0.22

    local bloco = display.newRoundedRect(cenaMenu, x*0.5, y*0.7, x*0.5, y*0.5, 100)
    bloco.alpha = 0.7
    bloco:setFillColor(0.1,0.1,0.1)
  
  -- BOTÕES
    local botaoJogar = display.newRoundedRect(cenaMenu, x*0.5, y*0.55, x*0.4, y*0.07, 100)
    botaoJogar:setFillColor(0.5,0,0.1)
    
    local textoJogar = display.newText(cenaMenu, 'JOGAR', botaoJogar.x, botaoJogar.y, fonte, 100)
    textoJogar:setFillColor(0.9,0.9,0.9)
  
    local botaoTutorial = display.newRoundedRect(cenaMenu, x*0.5, y*0.7, x*0.4, y*0.07, 100)
    botaoTutorial:setFillColor(0.5,0,0.1)
  
    local textoTutorial = display.newText(cenaMenu, 'TUTORIAL', botaoTutorial.x, botaoTutorial.y, fonte, 100)
    textoTutorial:setFillColor(0.9,0.9,0.9)
  
    local botaoCreditos = display.newRoundedRect(cenaMenu, x*0.5, y*0.85, x*0.4, y*0.07, 100)
    botaoCreditos:setFillColor(0.5,0,0.1)
  
    local textoCreditos = display.newText(cenaMenu, 'CREDITOS', botaoCreditos.x, botaoCreditos.y, fonte, 100)
    textoCreditos:setFillColor(0.9,0.9,0.9)

  -- FUNÇÃO DE TOQUE DOS BOTÕES
    function verificaToque(event)
      if event.phase == 'began' then
        if event.target == botaoJogar then
          composer.removeScene( "cenas.menu" )
          audio.play(audioClick)
          composer.gotoScene('cenas.jogo')
        elseif event.target == botaoTutorial then
          composer.gotoScene('cenas.tutorial',{
            time = 300,
            effect = "fade",
            audio.play(audioClick),
          })
        elseif event.target == botaoCreditos then
          composer.gotoScene('cenas.creditos',{
            time = 300,
            effect = "fade",
            audio.play(audioClick),
          })
        end
      end
    end
  
  -- EVENT LISTENERS
  botaoJogar: addEventListener('touch', verificaToque)
  botaoTutorial: addEventListener('touch', verificaToque)
  botaoCreditos: addEventListener('touch', verificaToque)
  
end


cena:addEventListener('create', cenas)
return cena