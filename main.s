###############################################################################
##                                 HELLTAKER                                ##
##############################################################################

.macro	drawImage(%frame,%imagem,%coord_x,%coord_y)
	# Desenha uma figura de qualquer tamanho na tela de bitmap
	#
	# a0: imagem
	# a1: coordenada x
	# a2: coordenada y
		la a0, %imagem
		lw t0, %frame			# Endereco da memoria vga
		li a1, %coord_x
		li a2, %coord_y
		lw t1, screen_width		# Carrega largura da tela
		mul t1, t1, a2			# Multiplica largura pela coordenada y
		add t0, t0, t1			# Adiciona multiplicacao ao endereco do frame
		add t0, t0, a1			# Adiciona a coordenada x ao endere�o do frame
		li t2, 4			# Carrega o tamanho de uma word na mem�ria
		rem t1, t0, t2			# Calcula o resto entre o endere�o da vga e 4
		beqz t1, gridOk			# Se n�o for divis�vel por 4 dara problema de desalinhamento de endere�amento da mem�ria
		sub t0, t0, t1			# Nesse caso, escolhe o endere�o v�lido imediatamente � esquerda
	gridOk:
		add t1, zero, a0		# Endere�o da imagem
		lw t2, 0(t1)			# Largura da imagem
		lw t3, 4(t1)			# Altura da imagem
		addi t1, t1, 8			# Muda t1 para o primeiro pixel da imagem, ap�s informa��es de altura e largura
		li t4, 0			# Iterador de colunas
		li t5, 0			# Iterador de linhas
	drawLoop:	
		beq t5, t3, endDraw		# Verifica se desenhou todas as linhas da imagem
		blt t4, t2, continueLine	# Se n�o chegou ao final da linha continua desenhando
		sub t0, t0, t4		# Reinicia o endere�o vga para o primeiro pixel da linha
		li t4, 0		# Reinicia o iterador de coluna
		addi t5, t5, 1		# Incrementa iterador de linha
		addi t0, t0, 320	# Pr�xima linha na mem�ria vga
		j drawLoop
	continueLine:
		lw t6, 0(t1)			# Carrega pixel da imagem
		li s0, 0xFF00FF			# Cor Magente (Transparente)
		beq t6, s0, transparent		# N�o desenha o pixel transparente
		sw t6, 0(t0)			# Escreve pixel na mem�ria vga
	transparent:
		addi t0, t0, 4			# Pr�ximo endere�o da mem�ria vga
		addi t1, t1, 4			# Pr�ximo pixel da imagem
		addi t4, t4, 4			# Incrementa iterador			
		j drawLoop
	endDraw:
		li a0, 0			# Limpa o registro pra retornar
		li a1, 0			# Limpa o registro pra retornar
		li a2, 0			# Limpa o registro pra retornar
.end_macro


.macro	drawImageNotImm(%frame,%imagem,%coord_x,%coord_y)
	# Desenha uma figura de qualquer tamanho na tela de bitmap
	#
	# a0: imagem
	# a1: coordenada x
	# a2: coordenada y
		la a0, %imagem
		lw t0, %frame			# Endereco da memoria vga
		add a1,zero,%coord_x
		add a2,zero, %coord_y
		lw t1, screen_width		# Carrega largura da tela
		mul t1, t1, a2			# Multiplica largura pela coordenada y
		add t0, t0, t1			# Adiciona multiplicacao ao endereco do frame
		add t0, t0, a1			# Adiciona a coordenada x ao endere�o do frame
		li t2, 4			# Carrega o tamanho de uma word na mem�ria
		rem t1, t0, t2			# Calcula o resto entre o endere�o da vga e 4
		beqz t1, gridOk			# Se n�o for divis�vel por 4 dara problema de desalinhamento de endere�amento da mem�ria
		sub t0, t0, t1			# Nesse caso, escolhe o endere�o v�lido imediatamente � esquerda
	gridOk:
		add t1, zero, a0		# Endere�o da imagem
		lw t2, 0(t1)			# Largura da imagem
		lw t3, 4(t1)			# Altura da imagem
		addi t1, t1, 8			# Muda t1 para o primeiro pixel da imagem, ap�s informa��es de altura e largura
		li t4, 0			# Iterador de colunas
		li t5, 0			# Iterador de linhas
	drawLoop:	
		beq t5, t3, endDraw		# Verifica se desenhou todas as linhas da imagem
		blt t4, t2, continueLine	# Se n�o chegou ao final da linha continua desenhando
		sub t0, t0, t4		# Reinicia o endere�o vga para o primeiro pixel da linha
		li t4, 0		# Reinicia o iterador de coluna
		addi t5, t5, 1		# Incrementa iterador de linha
		addi t0, t0, 320	# Pr�xima linha na mem�ria vga
		j drawLoop
	continueLine:
		lw t6, 0(t1)			# Carrega pixel da imagem
		li s0, 0xFF00FF			# Cor Magente (Transparente)
		beq t6, s0, transparent		# N�o desenha o pixel transparente
		sw t6, 0(t0)			# Escreve pixel na mem�ria vga
	transparent:
		addi t0, t0, 4			# Pr�ximo endere�o da mem�ria vga
		addi t1, t1, 4			# Pr�ximo pixel da imagem
		addi t4, t4, 4			# Incrementa iterador			
		j drawLoop
	endDraw:
		li a0, 0			# Limpa o registro pra retornar
		li a1, 0			# Limpa o registro pra retornar
		li a2, 0			# Limpa o registro pra retornar
.end_macro


.macro	clearFrame(%frame)
	# Desenha uma figura de qualquer tamanho na tela de bitmap
	
	li t0, 76800
	lw t1, %frame	# endereco inicial da Memoria VGA - Frame 0
	add t2, t0, t1		# endereco final 
	li t3,0x00000000	# cor vermelho|vermelho|vermelhor|vermelho
cf_loop: 	
	beq t1,t2,cf_fora	# Se for o �ltimo endere�o ent�o sai do loop
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	j cf_loop
cf_fora:	
.end_macro

.data

# Imagens
.include "imagens\menu_background.data"
.include "imagens\novo_jogo_alto_1.data"
.include "imagens\novo_jogo_baixo_1.data"
.include "imagens\sair_alto_1.data"
.include "imagens\sair_baixo_1.data"
.include "imagens\backgroundchatBelzebub.data"
.include "imagens\PrimeirochatBelzebub.data"
.include "imagens\SegundochatBelzebub.data"
.include "imagens\hero.data"
.include "imagens\mapa_1.data"
.include "imagens\tampao_mapa_1.data"

screen_width:	.word 320
screen_height:	.word 240

frame_zero: .word 0xFF000000
frame_one:  .word 0xFF100000

# Incluindo ecalls customizadas
#.include "MACROSv21.s"
#.include "SYSTEMv21.s"

.text
#==============================================================================
# Main Program ================================================================
#==============================================================================


mainLoop:

# Drawing Menu ================================================================

# Menu Background
	drawImage(frame_zero,helltaker_menu,0,0)		# Desenha plano de fundo no frame_zero
	drawImage(frame_one,helltaker_menu,0,0)		# Desenhando plano de fundo no frame_one
# Menu Buttons
drawButtons:
	#jal checkEnd
	
	drawImage(frame_zero,novo_jogo_alto_1,80,140)	    # Desenha bot�o superior no frame_zero
	drawImage(frame_zero,sair_baixo_1,85,190)		    # Desenha bot�o inferior no frame_zero
	
	
	drawImage(frame_one,novo_jogo_baixo_1,85,140)	 # Desenha bot�o superior no frame_one
	drawImage(frame_one,sair_alto_1,80,190)		# Desenha bot�o inferior no frame_one
	
selecaoMenuInicial:
	jal readKeyBlocking				# L� input do usu�rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c�digo ascii da tecla enter em t2
	beq a0,t2,menuInicialSelecionado		# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,mudarSelecao				# Se w for selecionado, muda sele��o
	beq a0,t0,mudarSelecao				# Se s for selecionado, muda sele��o
	j loopMenu 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
mudarSelecao:
	jal changeFrame					# Muda tela
loopMenu:
	j selecaoMenuInicial				#Reitera o loop
	
menuInicialSelecionado:
	drawImage(frame_one,backgroundchatBelzebub,0,0)  # Desenha o background do di�logo no frame 1
	drawImage(frame_zero,backgroundchatBelzebub,0,0) # Desenha o background do di�logo no frame o
	drawImage(frame_zero,PrimeirochatBelzebub,0,136) # Desenha o primeiro di�logo no frame 0
	drawImage(frame_one,SegundochatBelzebub,0,136)   # Desenha o segundo di�logo no frame 1
	jal readKeyBlocking				# Se o usu�rio apertar alguma tecla, mostra o pr�ximo frame
	jal changeFrame					
	jal readKeyBlocking				# Se o usu�rio apertar alguma ecla, segue o jogo (no caso, mostra o mapa)
	

# Fase 1 (Teste)
	clearFrame(frame_zero)
	clearFrame(frame_one)
	drawImage(frame_zero, mapa_1, 70, 20)
	drawImage(frame_one, mapa_1, 70, 20)
	drawImage(frame_zero, hero, 130, 80)
	drawImage(frame_one, hero, 130, 80)
	li a3, 2 	# Marca o posicionamento inincial do eixo y do her�i
	li a4, 3 	# Marca o posicionamento inincial do eixo x do her�i
	
fase_1:
	jal readKeyBlocking
	li t0, 'w'
	beq a0, t0 , moveParaCima
#	j casoA
moveParaCima:
	jal moverCima
	j fase_1
#casoA:
#	beq a0, 'a', moveParaEsquerda
#	j casoS
#moveParaEsquerda:
#	jal moverEsquerda
#	j fase_1	
#casoS:
#	beq a0, 's',moveParaBaixo
#	j casoD
#moveParaBaixo:
#	jal moverBaixo
#	j fase_1
#casoD:
#	beq a0, 'd', moveParaDireita
#	j Fase1_loop
#moveParaDireita:
#	jal moverDireita
#	j fase_1
#Fase1_loop
# 	j fase_1
	
	
	
	li a0,2000		# pausa de 2 segundos
	li a7,32		
	ecall
	
	clearFrame(frame_zero)	# apaga os frames
	clearFrame(frame_one)
endProgram:  	
	li a7, 10	# Syscall "exit"
	ecall
	

# Functions ===================================================================

checkEnd:
	add t3, zero, ra
	jal readKeyNonBlocking
	li t1, 27		# Carrega o caractere "esc"
	beq a0, t1, endProgram	# Finaliza programa se "esc" foi pressionado
	jr t3

readKeyBlocking:
# Pausa o programa e espera que o usu�rio pressione uma tecla para continuar
#
# caractere pressiona -> a0
	
	li t1, 0xFF200000		# Carrega o endere�o de status do KDMMIO
rkb_loop:
	lw t0, 0(t1)		# Carrega o status do teclado
	andi t0, t0, 0x0001	# Mascara o bit menos significativo. Por qu�?!
	beq t0, zero, rkb_loop	# Se n�o houver tecla pressionada repete at� que o usu�rio aperte algo
	lw a0, 4(t1)			# Carrega o caractere que foi pressionado
	sw a0, 12(t1)			# Escreve o caractere lido no display 
	ret
		

readKeyNonBlocking:
# Verifica se o usu�rio pressionou uma tecla, se n�o continua o programa, se
# sim, retorna o caractere pressionado
#
# caractere -> a0
	
	li t1, 0xFF200000	# Carrega o endere�o de status do KDMMIO
	lw t0, 0(t1)		# Carrega o status do teclado
	andi t0, t0, 0x0001	# Mascara o bit menos significativo. Por qu�?!
	beq t0, zero, rknb_end	# Se n�o houver tecla pressionada continua
	lw t2, 4(t1)		# Carrega o caractere que foi pressionado
	lw a0, 4(t1)		# Carrega em a0 (vari�vel de retorno) o caractere
	sw t2, 12(t1)		# Escreve o caractere lido no display
rknb_end:
	ret
	

changeFrame:	
	xori a5,a5,1
	li t0, 0xFF200604
	sw a5, 0(t0)	
	ret
	
colocarHeroi:			# Coloca o her�i no frame n�o mostrado
	li t1,70
	li t2, 20
	mul t2, t2, a3
	add t1, t1, t2   
	addi t1, t1, 20 #t1 armazena a coordenada x para pintar o her�i
	li t2, 20
	mul t2, t2,a4	#t2 armazena a coordenada y para pintar o her�i
	xori t4,a5,1   # t4 armazena o frame que *N�O* est� sendo mostrado
	beq t4,zero, heroiNoFrame0
	j heroiNoFrame1
heroiNoFrame0:
	drawImageNotImm(frame_zero,hero,t1,t2)  # coloca o tamp�o na posi��o antiga do personagem
	ret
heroiNoFrame1:
	drawImageNotImm(frame_one,hero,t1,t2)  # coloca o tamp�o na posi��o antiga do personagem
	ret
	
moverCima: 	
	jal colocarHeroi
	jal changeFrame
	xori t4,t4,1 # t4 armazena o frame que *N�O* est� sendo mostrado(posi��o antiga do her�i)
	addi t2,t2,-20	#t1 j� tem a coordenada x de coloca o tamp�o, t2 agora armazena a coordenada y do tamp�o
	beq t4,zero, tampaoNoFrame0
	j tampaoNoFrame1
tampaoNoFrame0:
	drawImageNotImm(frame_zero,tampao_mapa_1,t1,t2)  # coloca o tamp�o na posi��o antiga do personagem
	ret
tampaoNoFrame1:
	drawImageNotImm(frame_one,tampao_mapa_1,t1,t2)  # coloca o tamp�o na posi��o antiga do personagem
	ret
	