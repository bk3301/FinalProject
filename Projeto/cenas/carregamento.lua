-- COMPOSER
local composer = require('composer')

-- CENA
local cena = composer.newScene()

-- CRIANDO CENA CARREGAMENTO
function cena:create( event )
    local cenaCarregamento = self.view

    -- VARIAVEIS DE POSICIONAMENTO
    local x = display.contentWidth
    local y = display.contentHeight

    -- AUDIO

    audioTrident = audio.loadSound('recursos/audios/trident.mp3')
    audio.play(audioTrident)

    -- FUNDO
    local fundo = display.newRect(cenaCarregamento, x, y, x, y)
    fundo.x = x*0.5
    fundo.y = y*0.5
    fundo:setFillColor(1,1,1)

    -- ELEMENTOS DA LOGO
    local logo = display.newImageRect(cenaCarregamento, 'recursos/imagens/trident.png', x*0.2, y*0.4, x*0.3, y*0.1 )
    logo.x = x*0.5
    logo.y = y*0.37
    logo:setFillColor(1,0,0)

    local logo1 = display.newImageRect(cenaCarregamento, 'recursos/imagens/logoT.png', x*0.4, y*0.4, x*0.7, y*0.3 )
    logo1.x = x*0.5
    logo1.y = y*0.7
    logo1:setFillColor(1,0,0)

    -- LOAD
    local barra = 4

    transition.to ( barra, {
        time = 2500,
        onComplete = function()
            composer.gotoScene( 'cenas.carregamento2', { effect = 'fade', time = 500})
        end
    })

end

cena:addEventListener('create', cena)
return cena