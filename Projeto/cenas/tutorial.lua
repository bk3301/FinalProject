-- COMPOSER
local composer = require('composer')

-- CENA
local cena = composer.newScene()

-- CENA TUTORIAL
function cena:create( event )
	local cenaTutorial = self.view

	-- VARIAVEIS POSICIONAMENTO
	local x = display.contentWidth
	local y = display.contentHeight

	-- DECLARACAO DOS GRUPOS (CAMADAS)
	local grupoRevolver = display.newGroup()
	local grupoJogador = display.newGroup()
	local grupoExplicacao = display.newGroup()
	local grupoFundo = display.newGroup()

	cenaTutorial: insert( grupoFundo )
	cenaTutorial: insert( grupoJogador )
	cenaTutorial: insert( grupoRevolver )
	cenaTutorial: insert( grupoExplicacao )


	-- GRUPO FUNDO

	local fundo = display.newImageRect(grupoFundo, 'recursos/imagens/fundoMenu.png', x, y)
	fundo.x = x*0.5
	fundo.y = y*0.5

	local bloco = display.newRoundedRect(grupoFundo, x*0.5, y*0.5, x*0.55, y*0.95, 100)
	bloco.alpha = 0.9
	bloco:setFillColor(0.1,0.1,0.1)

	local botaoMenu = display.newRoundedRect(grupoFundo, x * 0.5, y * 0.88, x * 0.15, y * 0.09, 100)
	botaoMenu:setFillColor(0.5,0,0.1)

	local textoMenu = display.newText(grupoFundo, "MENU", botaoMenu.x, botaoMenu.y, 'recursos/fontes/fonte.ttf', 100)
	textoMenu:setFillColor(0.9,0.9,0.9)

	-- GRUPO JOGADOR

	local botaoProximoRevolver = display.newRoundedRect(grupoJogador, x * 0.68, y * 0.88, x * 0.15, y * 0.09, 100)
	botaoProximoRevolver:setFillColor(0.5,0,0.1)

	local textoProximoRevolver = display.newText(grupoJogador, "▶", botaoProximoRevolver.x*1.02, botaoProximoRevolver.y, 'recursos/fontes/fonte.ttf', 110)
	textoProximoRevolver:setFillColor(0.9,0.9,0.9)

	local textoJogador = display.newText(grupoJogador, '  "W,A,S,D"\n para mover', bloco.x*1.2, bloco.y*0.40, 'recursos/fontes/fonte.ttf', 100)
	textoJogador:setFillColor(0.9,0.9,0.9)

	local textoJogador2 = display.newText(grupoJogador, '  1 Ponto\n por inimigo', bloco.x*1.2, bloco.y*1.25, 'recursos/fontes/fonte.ttf', 100)
	textoJogador2:setFillColor(0.9,0.9,0.9)

	-- DECLARAÇÃO DA ANIMAÇÃO DO JOGADOR
	local spriteSheetJogador = graphics.newImageSheet("recursos/spritesheet/jogador.png", {
		width = 136 / 2,
		height = 136 / 2,
		numFrames = 4,
		sheetContentWidth = 136,
		sheetContentHeight = 136,
		xScale = 2,
		yScale = 2,
	})

	local jogadorCorrendo = {
		{ name = "correr", start = 1, count = 4, time = 500, loopCount = 0 },
		{ name = "parado", start = 1, count = 1, time = 0, loopCount = 0 },
	}

	-- JOGADOR
	local jogador = display.newSprite( spriteSheetJogador, jogadorCorrendo)
	jogador.x = x*0.38
	jogador.y = y*0.20
	jogador.xScale = x*0.005
	jogador.yScale = y*0.005
	jogador:setSequence('correr')
	jogador:play()
	grupoJogador: insert( jogador )


	-- DECLARAÇÃO DA ANIMAÇÃO DO INIMIGO
	local spriteSheetInimigo = graphics.newImageSheet( 'recursos/spritesheet/inimigo1.png',{
		width = 96/2,
		height = 48,
		numFrames = 2,
		sheetContentWidth = 96,
		sheetContentHeight = 48
	})

	local animacaoInimigo = {
		{name = 'parado', start = 1, count = 2, time = 500, loopCount = 0},
	}

	-- Inimigo
	local inimigo = display.newSprite( spriteSheetInimigo, animacaoInimigo)
	inimigo.x = x*0.37
	inimigo.y = y*0.63
	inimigo.xScale = x*0.003
	inimigo.yScale = y*0.003
	inimigo:setSequence('parado')
	inimigo:play()
	grupoJogador: insert( inimigo )
	

	-- GRUPO REVOLVER

	local textoAtirar = display.newText(grupoRevolver, ' "direcionais"\n para atirar', bloco.x*1.2, bloco.y*0.40, 'recursos/fontes/fonte.ttf', 100)
	textoAtirar:setFillColor(0.9,0.9,0.9)

	local textoRecarrega = display.newText(grupoRevolver, '       "R"\n para recarregar', bloco.x*1.2, bloco.y*1.25, 'recursos/fontes/fonte.ttf', 100)
	textoRecarrega:setFillColor(0.9,0.9,0.9)

	local botaoVoltarJogador = display.newRoundedRect(grupoRevolver, x * 0.33, y * 0.88, x * 0.15, y * 0.09, 100)
	botaoVoltarJogador:setFillColor(0.5,0,0.1)

	local textoVoltarJogardor = display.newText(grupoRevolver, "◀", botaoVoltarJogador.x*0.98, botaoVoltarJogador.y, 'recursos/fontes/fonte.ttf', 110)
	textoVoltarJogardor:setFillColor(0.9,0.9,0.9)

	local botaoProximoPontos = display.newRoundedRect(grupoRevolver, x * 0.68, y * 0.88, x * 0.15, y * 0.09, 100)
	botaoProximoPontos:setFillColor(0.5,0,0.1)

	local textoProximoPontos = display.newText(grupoRevolver, "▶", botaoProximoPontos.x*1.02, botaoProximoPontos.y, 'recursos/fontes/fonte.ttf', 110)
	textoProximoPontos:setFillColor(0.9,0.9,0.9)

	-- DECLARAÇÃO DA ANIMAÇÃO DO REVOLVER
	local spriteSheetRevolver = graphics.newImageSheet( 'recursos/spritesheet/revolver.png',{
		width = 1904/28,
		height = 68,
		numFrames = 28,
		sheetContentWidth = 1904,
		sheetContentHeight = 68
	})

	local animacaoRevolver = {
		{name = 'atirar', start = 1, count = 22, time = 4000, loopCount = 0},
		{name = 'recarrega', start = 23, count = 8, time = 1000, loopCount = 0}
	}

	-- REVOLVER
	local revolver1 = display.newSprite( spriteSheetRevolver, animacaoRevolver)
	revolver1.x = x*0.35
	revolver1.y = y*0.63
	revolver1.xScale = x*0.003
	revolver1.yScale = y*0.003
	revolver1:setSequence('recarrega')
	revolver1:play()
	

	local revolver2 = display.newSprite( spriteSheetRevolver, animacaoRevolver)
	revolver2.x = x*0.35
	revolver2.y = y*0.20
	revolver2.xScale = x*0.003
	revolver2.yScale = y*0.003
	revolver2:setSequence('atirar')
	revolver2:play()
	

	grupoRevolver: insert( revolver1 )
	grupoRevolver: insert( revolver2 )

	-- GRUPO PONTOS

	local botaoVoltarRevolver = display.newRoundedRect(grupoExplicacao, x * 0.33, y * 0.88, x * 0.15, y * 0.09, 100)
	botaoVoltarRevolver:setFillColor(0.5,0,0.1)

	local textoVoltarRevolver = display.newText(grupoExplicacao, "◀", botaoVoltarRevolver.x*0.98, botaoVoltarRevolver.y, 'recursos/fontes/fonte.ttf', 110)
	textoVoltarRevolver:setFillColor(0.9,0.9,0.9)

	local textoTutorial = display.newText(grupoExplicacao, 'Inimigos aparecem de portais\n   espalhados pelo mapa\n\n    Quanto maior o tempo\n   mais inimigos aparecem\n\n    Se perder as 3 vidas\n        o jogo acaba', bloco.x, bloco.y*0.88, 'recursos/fontes/fonte.ttf', 100)
    textoTutorial:setFillColor(0.9,0.9,0.9)

	-- ALPHA GRUPOS
	grupoJogador.alpha = 1
	grupoRevolver.alpha = 0
	grupoExplicacao.alpha = 0

	-- FUNCAO VERIFICA TOQUE
	function verificaToque( event )
		if event.phase == "began" then 
			if event.target == botaoMenu then
				composer.gotoScene("cenas.menu", {
					time = 300,
					effect = "fade",
					audio.play(audioClick),
				})

			elseif event.target == botaoProximoRevolver then
				timer.performWithDelay( 0, function()
					transition.to( grupoJogador, {
					time = 0,
					alpha = 0,
					audio.play( audioClick ),
					onComplete = function()
						transition.to( grupoRevolver, {
						time = 0,
						alpha = 1
						} )
					end
					})
				end, 1 )

			elseif event.target == botaoProximoPontos then
				timer.performWithDelay( 0, function()
					transition.to( grupoRevolver, {
					time = 0,
					alpha = 0,
					audio.play( audioClick ),
					onComplete = function()
						transition.to( grupoExplicacao, {
						time = 0,
						alpha = 1
						} )
					end
					})
				end, 1 )

			elseif event.target == botaoVoltarJogador then
				timer.performWithDelay( 0, function()
					transition.to( grupoRevolver, {
					time = 0,
					alpha = 0,
					audio.play( audioClick ),
					onComplete = function()
						transition.to( grupoJogador, {
						time = 0,
						alpha = 1
						} )
					end
					})
				end, 1 )

			elseif event.target == botaoVoltarRevolver then
				timer.performWithDelay( 0, function()
					transition.to( grupoExplicacao, {
					time = 0,
					alpha = 0,
					audio.play( audioClick ),
					onComplete = function()
						transition.to( grupoRevolver, {
						time = 0,
						alpha = 1
						} )
					end
					})
				end, 1 )

			end
		end
	end

	botaoMenu:addEventListener("touch", verificaToque)
	botaoProximoRevolver:addEventListener("touch", verificaToque)
	botaoProximoPontos:addEventListener("touch", verificaToque)
	botaoVoltarJogador:addEventListener("touch", verificaToque)
	botaoVoltarRevolver:addEventListener("touch", verificaToque)

end



cena:addEventListener('create', cena)
return cena