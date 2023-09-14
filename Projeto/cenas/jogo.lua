-- COMPOSER
local composer = require("composer")

-- CENA
local cena = composer.newScene()

-- BIBLIOTECA PERSPECTIVA
local perspective = require("perspective")

-- CAMERA
local camera = perspective.createView()

-- CAMADAS CAMERA
camera:prependLayer()

-- CRIANDO CENA JOGO
function cena:create(event)
	local cenaJogo = self.view

	-- DECLARAÇÕES

	-- POSICIONAMENTO
	local x = display.contentWidth
	local y = display.contentHeight

	-- FONTE
	local fonte = native.newFont("recursos/fontes/fonte.ttf")

	-- FISICA
	local physics = require("physics")
	physics.start()
	physics.setDrawMode("normal")
	physics.setGravity(0, 0)

	-- AUDIOS
	local musicaJogo = audio.loadStream("recursos/audios/musicaJogo.mp3")

	audio.play(musicaJogo, { channel = 31, loop = 0 })
	audio.setVolume(0.5, { chennel = 31 })
	audio.stop({ channel = 32 })

	-- GRUPOS
	local grupoFundo = display.newGroup()
	local grupoJogo = display.newGroup()
	local grupoGUI = display.newGroup()
	local grupoDerrota = display.newGroup()
	grupoDerrota.alpha = 0

	-- SPRITESHEETS E ANIMAÇÕES

	-- JOGADOR
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

	-- PORTAL
	local spriteSheetPortal = graphics.newImageSheet("recursos/spritesheet/portal.png", {
		width = 1280 / 5,
		height = 512 / 2,
		numFrames = 9,
		sheetContentWidth = 1280,
		sheetContentHeight = 512,
	})

	local animacaoPortal = {
		{ name = "portal", frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }, time = 700, loopCount = 0 },
	}

	-- INIMIGO
	local spriteSheetInimigo = graphics.newImageSheet("recursos/spritesheet/inimigo1.png", {
		width = 96 / 2,
		height = 48,
		numFrames = 2,
		sheetContentWidth = 96,
		sheetContentHeight = 48,
	})

	local animacaoInimigo = {
		{ name = "inimigo", frames = { 1, 2 }, time = 400, loopCount = 0 },
	}

	-- REVOLVER
	local spriteSheetRevolver = graphics.newImageSheet("recursos/spritesheet/revolver.png", {
		width = 1904 / 28,
		height = 68,
		numFrames = 28,
		sheetContentWidth = 1904,
		sheetContentHeight = 68,
	})

	local animacaoRevolver = {
		{ name = "6.Projeteis", start = 1, count = 0, time = 0, loopCount = 0 },
		{ name = "5.Projeteis", start = 2, count = 4, time = 200, loopCount = 1 },
		{ name = "4.Projeteis", start = 6, count = 4, time = 200, loopCount = 1 },
		{ name = "3.Projeteis", start = 10, count = 4, time = 200, loopCount = 1 },
		{ name = "2.Projeteis", start = 14, count = 4, time = 200, loopCount = 1 },
		{ name = "1.Projeteis", start = 18, count = 4, time = 200, loopCount = 1 },
		{ name = "0.Projeteis", start = 22, count = 0, time = 0, loopCount = 0 },
		{ name = "recarregar", start = 23, count = 5, time = 1000, loopCount = 1 },
	}

	-- GRUPO FUNDO

	--FUNDO
	local fundo = display.newImageRect(cenaJogo, "recursos/imagens/mapinha.png", 5000, 5000, x, y)
	fundo.x = x * 0.5
	fundo.y = y * 0.5
	grupoFundo:insert(fundo)
	camera:add(fundo, 3)

	--TRONCOS DO FUNDO
	local fileteEsquerda = display.newRect(cenaJogo, x, y, 40, 2550)
	fileteEsquerda.x = -70
	fileteEsquerda.y = y * 0.5
	fileteEsquerda.alpha = 0
	grupoFundo:insert(fileteEsquerda)
	camera:add(fileteEsquerda, 1)
	physics.addBody(fileteEsquerda, "static", {
		bounce = 0,
		box = { x = 0, y = 0, halfWidth = 20, halfHeight = 2550 / 2 },
	})
	fileteEsquerda.id = "fileteID"

	local fileteDireita = display.newRect(cenaJogo, x, y, 20, 2550)
	fileteDireita.x = 2470
	fileteDireita.y = y * 0.5
	fileteDireita.alpha = 0
	grupoFundo:insert(fileteDireita)
	camera:add(fileteDireita, 1)
	physics.addBody(fileteDireita, "static", {
		bounce = 0,
		box = { x = 0, y = 0, halfWidth = 20, halfHeight = 2550 / 2 },
	})
	fileteDireita.id = "fileteID"

	local fileteBaixo = display.newRect(cenaJogo, x, y, 2550, 20)
	fileteBaixo.x = 1200
	fileteBaixo.y = 1820
	fileteBaixo.alpha = 0
	grupoFundo:insert(fileteBaixo)
	camera:add(fileteBaixo, 1)
	physics.addBody(fileteBaixo, "static", {
		bounce = 0,
		box = { x = 0, y = 0, halfWidth = 2550 / 2, halfHeight = 20 },
	})
	fileteBaixo.id = "fileteID"

	local fileteCima = display.newRect(cenaJogo, x, y, 2550, 20)
	fileteCima.x = 1200
	fileteCima.y = -750
	fileteCima.alpha = 0
	grupoFundo:insert(fileteCima)
	camera:add(fileteCima, 1)
	physics.addBody(fileteCima, "static", {
		bounce = 0,
		box = { x = 0, y = 0, halfWidth = 2550 / 2, halfHeight = 20 },
	})
	fileteCima.id = "fileteID"

	-- GRUPO GUI

	-- ICONES DE VIDA
	local iconeVida1 = display.newImageRect(cenaJogo, "recursos/imagens/vida.png", x * 0.06, y * 0.1)
	iconeVida1.x = x * 0.08
	iconeVida1.y = y * 0.1
	grupoGUI:insert(iconeVida1)

	local iconeVida2 = display.newImageRect(cenaJogo, "recursos/imagens/vida.png", x * 0.06, y * 0.1)
	iconeVida2.x = x * 0.15
	iconeVida2.y = y * 0.1
	grupoGUI:insert(iconeVida2)

	local iconeVida3 = display.newImageRect(cenaJogo, "recursos/imagens/vida.png", x * 0.06, y * 0.1)
	iconeVida3.x = x * 0.22
	iconeVida3.y = y * 0.1
	grupoGUI:insert(iconeVida3)

	--PONTUAÇÃO
	local pontos = 0

	local pontosTexto = display.newText(cenaJogo, pontos, x * 0.9, y * 0.10, fonte, x * 0.08, y * 0.08)
	pontosTexto:setFillColor(0, 0, 0)
	grupoGUI:insert(pontosTexto)

	-- REVOLVER
	local revolver = display.newSprite(spriteSheetRevolver, animacaoRevolver)
	revolver.x = x * 0.8
	revolver.y = y * 0.9
	grupoGUI:insert(revolver)
	revolver.xScale = x * 0.003
	revolver.yScale = y * 0.003
	revolver:setSequence("6.Projeteis")
	revolver:play()

	-- MUNIÇÃO
	local municao = 6
	local clip = true

	local municaoContador = display.newText(cenaJogo, municao, x * 0.9, y * 0.9, fonte, x * 0.08, y * 0.08)
	grupoGUI:insert(municaoContador)
	municaoContador:setFillColor(0, 0, 0)

	-- GRUPO JOGO

	--JOGADOR
	local jogador = display.newSprite(cenaJogo, spriteSheetJogador, jogadorCorrendo)
	grupoJogo:insert(jogador)
	jogador.x = x * 0.5
	jogador.y = y * 0.5
	physics.addBody(jogador, "dynamic", { density = 1.0, friction = 0.3, bounce = 0 })
	jogador.direcao = "parado"
	jogador.vivo = true
	jogador.isFixedRotation = true
	jogador.id = "jogadorID"
	jogador.vidas = 3
	jogador.cooldown = false
	jogador:setSequence("parado")
	jogador:play()
	camera:add(jogador, 1)
	camera:setFocus(jogador)
	camera:track()
	jogador.xScale = 2
	jogador.yScale = 2

	-- PORTAIS
	local portal = display.newSprite(spriteSheetPortal, animacaoPortal)
	grupoJogo:insert(portal)
	camera:add(portal, 2)
	portal.x = 2200
	portal.y = 1600
	portal:play()

	local portal2 = display.newSprite(spriteSheetPortal, animacaoPortal)
	grupoJogo:insert(portal2)
	camera:add(portal2, 2)
	portal2.x = 190
	portal2.y = -500
	portal2.rotation = 180
	portal2:play()

	-- GRUPO DERROTA

	-- FUNDO
	local blocoGameOver = display.newImageRect(cenaJogo, "recursos/imagens/blodd.png", x , y, x, y)
	blocoGameOver.x = x*0.5
	blocoGameOver.y = y*0.5
	camera:add(blocoGameOver, 1)
	grupoDerrota:insert(blocoGameOver)
	blocoGameOver.alpha = 1

	--BOTÕES
	

	-- TEXTOS
	
	local gameOver = display.newImageRect(grupoDerrota, "recursos/imagens/gameOver.png", x * 0.5, y * 0.8)
	camera:add(gameOver, 1)
	grupoDerrota:insert(gameOver)
	gameOver.x = x * 0.5
	gameOver.y = y * 0.3
	gameOver:setFillColor(0, 0, 0)

	-- FUNÇÕES
	-- PONTOS
	-- ATUALIZAR PONTOS
	function atualizaPontos()
		pontos = pontos + 1
		pontosTexto.text = pontos
	end

	-- INIMIGOS
	--TABELA INIMIGOS
	local inimigos = {}

	--FUNÇÕES CRIAR INIMIGO
	local function criarInimigo(x, y)
		if jogador.vivo == true then
			local inimigo1 = display.newSprite(spriteSheetInimigo, animacaoInimigo)
			grupoJogo:insert(inimigo1)
			camera:add(inimigo1, 1)
			physics.addBody(inimigo1, "dynamic", { density = 1.0, friction = 0.3, bounce = 0 })
			inimigo1.x = 190
			inimigo1.y = -500
			table.insert(inimigos, inimigo1)
			inimigo1:play()
			inimigo1.id = "inimigoID"
			inimigo1.isFixedRotation = true
		end
	end

	local function criarInimigo2(x, y)
		if jogador.vivo == true then
			local inimigo = display.newSprite(spriteSheetInimigo, animacaoInimigo)
			grupoJogo:insert(inimigo)
			camera:add(inimigo, 1)
			physics.addBody(inimigo, "dynamic", { density = 1.0, friction = 0.3, bounce = 0 })
			inimigo.x = 2200
			inimigo.y = 1600
			table.insert(inimigos, inimigo)
			inimigo:play()
			inimigo.id = "inimigoID"
			inimigo.isFixedRotation = true
		end
	end

	--TIMER CRIAR INIMIGO
	function criarInimigoTimer()
		local x, y = escolherPosicaoAleatoria()
		criarInimigo(x, y)

		x, y = escolherPosicaoAleatoria()
		criarInimigo2(x, y)
	end

	-- DIFICULDADE
	local tempoDiminui = 10000

	local tempoInicial = 2000

	local obstaculoTimer = timer.performWithDelay(tempoInicial, criarInimigo, 0)

	local function diminuirTimer()
		timer.cancel(obstaculoTimer)
		tempoInicial = tempoInicial - 500
		obstaculoTimer = timer.performWithDelay(tempoInicial, criarInimigo, 0)
	end

	local function atualizaTempo()
		if tempoInicial >= 501 then
			diminuirTimer()
		end
	end

	timer.performWithDelay(tempoDiminui, atualizaTempo, 0)

	local tempoDiminui2 = 10000

	local tempoInicial2 = 2000

	local obstaculoTimer2 = timer.performWithDelay(tempoInicial2, criarInimigo2, 0)

	local function diminuirTimer2()
		timer.cancel(obstaculoTimer2)
		tempoInicial2 = tempoInicial2 - 500
		obstaculoTimer2 = timer.performWithDelay(tempoInicial2, criarInimigo2, 0)
	end

	local function atualizaTempo2()
		if tempoInicial2 >= 501 then
			diminuirTimer2()
		end
	end

	timer.performWithDelay(tempoDiminui2, atualizaTempo2, 0)

	-- FUNÇÃO DE REMOVER INIMIGOS
	function removeInimigos()
		for i = #inimigos, 1, -1 do
			if inimigos[i].y > y * 2 then
				display.remove(inimigos[i])
				table.remove(inimigos, i)
			end
		end
	end

	-- DANO
	--FUNÇÃO DE VERIFICAR DANO
	function verificaDano()
		if jogador.vidas == 2 then
			audio.play(audioJogadorDano)
			display.remove(iconeVida3)

			local iconeDano3 = display.newImageRect(cenaJogo, "recursos/imagens/dano.png", x * 0.06, y * 0.1)
			iconeDano3.x = x * 0.22
			iconeDano3.y = y * 0.1
			grupoGUI:insert(iconeDano3)
		elseif jogador.vidas == 1 then
			audio.play(audioJogadorDano)
			display.remove(iconeVida2)

			local iconeDano2 = display.newImageRect(cenaJogo, "recursos/imagens/dano.png", x * 0.06, y * 0.1)
			iconeDano2.x = x * 0.15
			iconeDano2.y = y * 0.1
			grupoGUI:insert(iconeDano2)
		elseif jogador.vidas == 0 then
			audio.play(audioJogadorDano)
			display.remove(iconeVida1)

			local iconeDano1 = display.newImageRect(cenaJogo, "recursos/imagens/dano.png", x * 0.06, y * 0.1)
			iconeDano1.x = x * 0.08
			iconeDano1.y = y * 0.1
			grupoGUI:insert(iconeDano1)

			local rip = display.newImageRect(cenaJogo, "recursos/imagens/rip.png", x * 0.04, y * 0.08)
			rip.x = x * 0.5
			rip.y = y * 0.5
			grupoJogo:insert(rip)

			jogador.vivo = false
			jogador.alpha = 0
			grupoDerrota.alpha = 1
			grupoGUI.alpha = 0
			physics.pause()
			
			audio.stop({ channel = 31 })
			audio.play(audioGameOver)
		end
	end
	
	local menuu = composer.getSceneName( "cenas.menu" )



	
	-- POSIÇÃO
	--VELOCIDADE MOVIMENTO DO JOGADOR
	local velocidadeMov = 500

	--TABELA TECLAS PRESSIONADAS
	local teclasPress = {}

	--POSIÇÃO JOGADOR
	local jogadorX = jogador.x
	local jogadorY = jogador.y

	--ULTIMA DIREÇÃO
	local ultimaDirecao = "parado"

	--ATUALIZA POSIÇÃO JOGADOR
	function atualizaJogador()
		local xVelocidade = 0
		local yVelocidade = 0

		if teclasPress["w"] then
			yVelocidade = -1
			ultimaDirecao = "cima"
		elseif teclasPress["s"] then
			yVelocidade = 1
			ultimaDirecao = "baixo"
		end

		if teclasPress["a"] then
			xVelocidade = -1
			ultimaDirecao = "esquerda"
		elseif teclasPress["d"] then
			xVelocidade = 1
			ultimaDirecao = "direita"
		end

		--NORMALIZAR VETOR DE MOVIMENTO DIAGONAL
		local magnitude = math.sqrt(xVelocidade ^ 2 + yVelocidade ^ 2)
		if magnitude > 0 then
			xVelocidade = xVelocidade / magnitude
			yVelocidade = yVelocidade / magnitude
		end

		jogador:setLinearVelocity(xVelocidade * velocidadeMov, yVelocidade * velocidadeMov)

		--VERIFICA SE O JOGADOR SE MOVIMENTA, DANDO PLAY NA ANIMAÇÃO DE CORRIDA OU PARADO
		if xVelocidade == 0 and yVelocidade == 0 then
			ultimaDirecao = "parado"
		end

		if jogador.direcao ~= ultimaDirecao then
			jogador.direcao = ultimaDirecao
			if ultimaDirecao == "cima" or ultimaDirecao == "baixo" or ultimaDirecao == "direita" then
				jogador:setSequence("correr")
				jogador.xScale = 2
			elseif ultimaDirecao == "esquerda" then
				jogador:setSequence("correr")
				jogador.xScale = -2
			else
				jogador:setSequence("parado")
			end
			jogador:play()
		end
		jogadorX, jogadorY = jogador.x, jogador.y
	end

	--EVENTO PRESSIONAR TECLA
	function pressTecla(event)
		if event.phase == "down" then
			teclasPress[event.keyName] = true
		elseif event.phase == "up" then
			teclasPress[event.keyName] = nil
		end
	end

	-- VELOCIDADE DE MOVIMENTO DO INIMIGO
	local inimigoVelocidade = 300

	--ATUALIZA POSIÇÃO INIMIGO
	function atualizaInimigo()
		for _, inimigo in ipairs(inimigos) do
			local angulo = math.atan2(jogador.y - inimigo.y, jogador.x - inimigo.x)
			local xVelocidade = math.cos(angulo) * inimigoVelocidade
			local yVelocidade = math.sin(angulo) * inimigoVelocidade
			inimigo:setLinearVelocity(xVelocidade, yVelocidade)
		end
	end

	--ESCOLHER POSIÇÃO DE SPAWN ALEATÓRIA
	function escolherPosicaoAleatoria()
		local posX, posY
		local lado = math.random(4) --LADO ALEATORIO ATÉ 4

		if lado == 1 then
			posX = math.random(50, x - 50)
			posY = -50 --CIMA
		elseif lado == 2 then
			posX = math.random(50, x - 50)
			posY = y + 50 --BAIXO
		elseif lado == 3 then
			posX = -50
			posY = math.random(50, y - 50) --ESQUERDA
		else
			posX = x + 50
			posY = math.random(50, y - 50) --DIREITA
		end
		return posX, posY
	end

	-- REVOLVER E MECÂNICA DE TIRO
	-- FUNÇÃO PARA ADICIONAR PROJETEIS
	function addProjeteis(a, b, c, d)
		local projeteis = display.newImageRect(grupoJogo, "recursos/imagens/projetil.png", x * 0.07, y * 0.09)
		projeteis.x = jogador.x + c
		projeteis.y = jogador.y + d
		projeteis.id = "projeteisID"
		camera:add(projeteis, 1)
		physics.addBody(projeteis, "kinematic", { radius = 25 })
		projeteis:setLinearVelocity(a, b)
	end

	-- FUNÇÃO DE COOLDOWN
	function cooldown()
		jogador.cooldown = true

		timer.performWithDelay(200, function()
			jogador.cooldown = false
		end, 1)
	end

	-- FUNÇÃO DA ANIMÇÃO DE ATIRAR COM O REVOLVER
	function verificaRevolver()
		if municao == 6 then
			revolver:setSequence("6.Projeteis")
			revolver:play()
		elseif municao == 5 then
			revolver:setSequence("5.Projeteis")
			revolver:play()
		elseif municao == 4 then
			revolver:setSequence("4.Projeteis")
			revolver:play()
		elseif municao == 3 then
			revolver:setSequence("3.Projeteis")
			revolver:play()
		elseif municao == 2 then
			revolver:setSequence("2.Projeteis")
			revolver:play()
		elseif municao == 1 then
			revolver:setSequence("1.Projeteis")
			revolver:play()
		elseif municao == 0 then
			revolver:setSequence("0.Projeteis")
			revolver:play()
		end
	end

	-- FUNÇÃO PARA RECARREGAR O REVOLVER
	function recarrega(event)
		if
			event.phase == "down"
			and event.keyName == "r"
			and municao >= 0
			and jogador.cooldown == false
			and jogador.vivo == true
		then
			jogador.cooldown = true
			revolver:setSequence("recarregar")
			revolver:play()

			transition.to(municaoContador, {
				time = 1000,
				onComplete = function()
					municao = 6
					verificaRevolver()
					municaoContador:setFillColor(0, 0, 0)
					audio.play(audioRecarregar)
					municaoContador.text = municao
					clip = true
					jogador.cooldown = false
				end,
			})
		end
	end

	--FUNÇÃO PARA ATUALIZA A MUNICAO
	function atualizaMunicao()
		if municao >= 1 then
			municao = municao - 1
			municaoContador.text = municao
		end
	end

	-- FUNCAO PARA EFEITOS DE ATIRAR SEM MUNIÇÃO
	function semMunicao()
		if clip == true and jogador.vivo == true then
			local semMunicaoTexto = display.newText(
				cenaJogo,
				"sem municao",
				jogador.x,
				jogador.y - jogador.height,
				fonte,
				x * 0.05,
				y * 0.05
			)
			grupoGUI:insert(semMunicaoTexto)
			camera:add(semMunicaoTexto, 1)
			semMunicaoTexto:setFillColor(1, 0, 0)

			transition.blink(semMunicaoTexto, {
				time = 1000,
			})

			transition.to(semMunicaoTexto, {
				time = 1000,
				y = jogador.y - jogador.height * 1.5,
				onComplete = function()
					display.remove(semMunicaoTexto)
				end,
			})

			clip = false
		end
	end

	-- FUNÇÃO ATIRAR
	function atirar(event)
		if event.phase == "down" and municao >= 1 and jogador.cooldown == false and jogador.vivo == true then
			if event.keyName == "up" then
				addProjeteis(0, -2000, 0, -jogador.height * 0.73)
				atualizaMunicao()
				verificaRevolver()
				cooldown()
				audio.play(audioAtirar)
			elseif event.keyName == "down" then
				addProjeteis(0, 2000, 0, jogador.height * 0.73)
				atualizaMunicao()
				verificaRevolver()
				cooldown()
				audio.play(audioAtirar)
			elseif event.keyName == "left" then
				addProjeteis(-2000, 0, -jogador.width * 0.73, 0)
				atualizaMunicao()
				verificaRevolver()
				cooldown()
				audio.play(audioAtirar)
			elseif event.keyName == "right" then
				addProjeteis(2000, 0, jogador.width * 0.73, 0)
				atualizaMunicao()
				verificaRevolver()
				cooldown()
				audio.play(audioAtirar)
			end
		end

		if event.phase == "up" and municao == 0 and jogador.cooldown == false then
			if
				event.keyName == "up"
				or event.keyName == "down"
				or event.keyName == "left"
				or event.keyName == "right"
			then
				municaoContador:setFillColor(1, 0, 0)
				semMunicao()
				verificaRevolver()
				cooldown()
				audio.play(audioSemMunicao)
			end
		end
	end

	-- COLISÃO

	--FUNÇÃO DE COLISÃO
	function verificaColisao(event)
		local objeto1 = event.object1
		local objeto2 = event.object2

		if event.phase == "began" or event.phase == "moved" then
			if objeto1.id == "projeteisID" and objeto2.id == "inimigoID" then
				display.remove(objeto1)
				audio.play(audioInimigoMorto)
				atualizaPontos()
				for i = #inimigos, 1, -1 do
					if inimigos[i] == objeto2 then
						transition.blink(inimigos[i], { time = 200 })
						transition.to(inimigos[i], {
							time = 200,
							xScale = 0,
							yScale = 0,
							onComplete = function()
								display.remove(inimigos[i])
								table.remove(inimigos, i)
							end,
						})
					end
				end
			elseif objeto1.id == "inimigoID" and objeto2.id == "projeteisID" then
				display.remove(objeto2)
				audio.play(audioInimigoMorto)
				atualizaPontos()
				for i = #inimigos, 1, -1 do
					if inimigos[i] == objeto1 then
						transition.blink(inimigos[i], { time = 200 })
						transition.to(inimigos[i], {
							time = 200,
							xScale = 0,
							yScale = 0,
							onComplete = function()
								display.remove(inimigos[i])
								table.remove(inimigos, i)
							end,
						})
					end
				end
			end

			if
				(objeto1.id == "jogadorID" and objeto2.id == "inimigoID")
				or (objeto1.id == "inimigoID" and objeto2.id == "jogadorID")
			then
				if jogador.vidas >= 1 then
					jogador.vidas = jogador.vidas - 1
					verificaDano()
				end
			end
		end
	end

	-- EVENT LISTENERS E RUNTIMERS
	-- TECLAS E POSIÇÕES
	Runtime:addEventListener("key", pressTecla)
	Runtime:addEventListener("enterFrame", atualizaJogador)
	Runtime:addEventListener("enterFrame", atualizaInimigo)

	-- ATIRAR E RECARREGAR
	Runtime:addEventListener("key", atirar)
	Runtime:addEventListener("key", recarrega)

	-- REMOVER INIMIGOS E COLISÃO
	Runtime:addEventListener("enterFrame", removeInimigos)
	Runtime:addEventListener("collision", verificaColisao)

	-- FUNÇÃO REINICIAR
	function reinicia()
		composer.removeScene("cenas.jogo")
		composer.removeScene("cenas.menu")
	end


	
end

cena:addEventListener("create", cena)
return cena
