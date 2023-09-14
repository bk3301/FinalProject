-- COMPOSER
local composer = require('composer')

--CENA
local cena = composer.newScene()

--CRIANDO CENA CARREGAMENTO2
function cena:create( event )
    local cenaCarregamento2 = self.view

    -- VARIAVEIS DE POSICIONAMENTO
    local x = display.contentWidth
    local y = display.contentHeight

    -- FUNDO
    local fundo = display.newImageRect(cenaCarregamento2, 'recursos/imagens/logo.png', x*0.6, y*0.6, x, y)
    fundo.x = x*0.5
    fundo.y = y*0.34
    fundo:setFillColor(1,1,1)

    -- TEXTO CARREGANDO
    local texto = display.newText(cenaCarregamento2, 'Carregando...', x*0.5, y*0.70, 'recursos/fontes/fonte.ttf', 80 )
    texto:setFillColor(1, 1, 1)

    -- LOAD
    local barra = 3

    transition.to ( barra, {
        time = 4000,
        onComplete = function()
            composer.gotoScene( 'cenas.menu', { effect = 'fade', time = 1500})
        end
    })

end

cena:addEventListener('create', cena)
return cena