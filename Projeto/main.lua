local composer = require('composer')

-- CENA QUE O PROJETO IRA INICIAR
composer.gotoScene('cenas.carregamento')
-- REMOVE A BARRA DE STATUS
display.setStatusBar(display.HiddenStatusBar)

-- VARIAVEIS GLOBAIS
fonte = 'recursos/fontes/fonte.ttf'

audioAtirar = audio.loadSound('recursos/audios/shoot3.wav')
audioSemMunicao = audio.loadSound('recursos/audios/select3.wav')
audioRecarregar = audio.loadSound('recursos/audios/pickup1.wav')
audioClick = audio.loadSound('recursos/audios/select1.wav')
audioInimigoMorto = audio.loadSound('recursos/audios/hurt2.wav')
audioJogadorDano = audio.loadSound('recursos/audios/hurt3.wav')
audioGameOver = audio.loadSound('recursos/audios/gameOver.mp3')