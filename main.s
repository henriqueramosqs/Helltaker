###############################################################################
##                                 HELLTAKER                                ##
##############################################################################
.data

# Imagens
.include "imagens\helltaker_menu.data"
.include "imagens\novo_jogo_alto.data"
.include "imagens\novo_jogo_baixo.data"
.include "imagens\sair_alto.data"
.include "imagens\sair_baixo.data"


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
	jal checkEnd	# Se "esc" pressionado, termina programa

# Drawing Menu ================================================================

# Menu Background
	la a0, helltaker_menu	# Sele��o do plano de fundo
	jal drawImage		# Desenhando plano de fundo
# Menu Buttons
drawButtons:
	jal checkEnd
	
	la a0, novo_jogo_alto 	# Sele��o da imagem
	li a1, 80		# Coord X do bot�o
	li a2, 140		# Coorde Y do bot�o
	jal drawImage		# Desenhando bot�o "novo jogo"
	
	la a0, sair_baixo	# Sele��o da imagem
	li a1, 85		# Coord X do bot�o
	li a2, 190		# Coord Y do bot�o
	jal drawImage		# Desenhando bot�o "sair"
	j drawButtons
	
	
	
	
	j mainLoop  	
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


drawImage:
# Desenha uma figura de qualquer tamanho na tela de bitmap
#
# a0: imagem
# a1: coordenada x
# a2: coordenada y

	lw t0, frame_zero		# Endera�o da mem�ria vga
	lw t1, screen_width		# Carrega largura da tela
	mul t1, t1, a2			# Multiplica largura pela coordenada y
	add t0, t0, t1			# Adiciona multiplica��o ao endere�o do frame
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
	sw t6, 0(t0)			# Escreve pixel na mem�ria vga
	addi t0, t0, 4			# Pr�ximo endere�o da mem�ria vga
	addi t1, t1, 4			# Pr�ximo pixel da imagem
	addi t4, t4, 4			# Incrementa iterador			
	j drawLoop
endDraw:
	li a0, 0			# Limpa o registro pra retornar
	li a1, 0			# Limpa o registro pra retornar
	li a2, 0			# Limpa o registro pra retornar
	ret