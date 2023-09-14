-- COMPOSER
local composer = require('composer')

-- CENA
local cena = composer.newScene()

-- CENA CREDITOS
function cena:create( event )
    local cenaCreditos = self.view

    -- VARIAVEIS POSICIONAMENTO
    local x = display.contentWidth
	local y = display.contentHeight

    -- FUNDO CREDITOS
    local fundo = display.newImageRect(cenaCreditos, 'recursos/imagens/fundoMenu.png', x, y)
    fundo.x = x*0.5
    fundo.y = y*0.5

    -- BLOCO CREDITOS
    local bloco = display.newRoundedRect(cenaCreditos, x*0.5, y*0.5, x*0.55, y*0.95, 100)
    bloco.alpha = 0.9
    bloco:setFillColor(0.1,0.1,0.1)

    -- TEXTO CREDITOS
    local textoCreditos = display.newText(cenaCreditos, '     Desenvolvido por: \n \n    Leonardo Oliveira\n \n       Victor Molon\n \n     Vinicius Siqueira', bloco.x*0.92, bloco.y*0.84, fonte, 110)
    textoCreditos:setFillColor(0.9,0.9,0.9)
    
    -- BOTAO VOLTAR
	local botaoVoltar = display.newRoundedRect(cenaCreditos, x * 0.5, y * 0.88, x * 0.2, y * 0.09, 100)
	botaoVoltar:setFillColor(0.5,0,0.1)

	-- TEXTO VOLTAR
	local textoVoltar = display.newText(cenaCreditos, "Voltar", botaoVoltar.x, botaoVoltar.y, fonte, 110)
    textoVoltar:setFillColor(0.9,0.9,0.9)

	-- FUNCAO VERIFICA TOQUE
	function verificaToque(event)
		if event.phase == "began" then
			composer.gotoScene("cenas.menu", {
				time = 300,
				effect = "fade",
				audio.play(audioClick),
			})
		end
	end
	botaoVoltar:addEventListener("touch", verificaToque)

end

cena:addEventListener('create', cena)
return cena