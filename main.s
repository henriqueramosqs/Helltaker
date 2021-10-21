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
		add t0, t0, a1			# Adiciona a coordenada x ao endere?o do frame
		li t2, 4			# Carrega o tamanho de uma word na mem?ria
		rem t1, t0, t2			# Calcula o resto entre o endere?o da vga e 4
		beqz t1, gridOk			# Se n?o for divis?vel por 4 dara problema de desalinhamento de endere?amento da mem?ria
		sub t0, t0, t1			# Nesse caso, escolhe o endere?o v?lido imediatamente ? esquerda
	gridOk:
		add t1, zero, a0		# Endere?o da imagem
		lw t2, 0(t1)			# Largura da imagem
		lw t3, 4(t1)			# Altura da imagem
		addi t1, t1, 8			# Muda t1 para o primeiro pixel da imagem, ap?s informa??es de altura e largura
		li t4, 0			# Iterador de colunas
		li t5, 0			# Iterador de linhas
	drawLoop:	
		beq t5, t3, endDraw		# Verifica se desenhou todas as linhas da imagem
		blt t4, t2, continueLine	# Se n?o chegou ao final da linha continua desenhando
		sub t0, t0, t4		# Reinicia o endere?o vga para o primeiro pixel da linha
		li t4, 0		# Reinicia o iterador de coluna
		addi t5, t5, 1		# Incrementa iterador de linha
		addi t0, t0, 320	# Pr?xima linha na mem?ria vga
		j drawLoop
	continueLine:
		lw t6, 0(t1)			# Carrega pixel da imagem
		li s0, 0xFF00FF			# Cor Magente (Transparente)
		beq t6, s0, transparent		# N?o desenha o pixel transparente
		sw t6, 0(t0)			# Escreve pixel na mem?ria vga
	transparent:
		addi t0, t0, 4			# Pr?ximo endere?o da mem?ria vga
		addi t1, t1, 4			# Pr?ximo pixel da imagem
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
		add t0, t0, a1			# Adiciona a coordenada x ao endere?o do frame
		li t2, 4			# Carrega o tamanho de uma word na mem?ria
		rem t1, t0, t2			# Calcula o resto entre o endere?o da vga e 4
		beqz t1, gridOk			# Se n?o for divis?vel por 4 dara problema de desalinhamento de endere?amento da mem?ria
		sub t0, t0, t1			# Nesse caso, escolhe o endere?o v?lido imediatamente ? esquerda
	gridOk:
		add t1, zero, a0		# Endere?o da imagem
		lw t2, 0(t1)			# Largura da imagem
		lw t3, 4(t1)			# Altura da imagem
		addi t1, t1, 8			# Muda t1 para o primeiro pixel da imagem, ap?s informa??es de altura e largura
		li t4, 0			# Iterador de colunas
		li t5, 0			# Iterador de linhas
	drawLoop:	
		beq t5, t3, endDraw		# Verifica se desenhou todas as linhas da imagem
		blt t4, t2, continueLine	# Se n?o chegou ao final da linha continua desenhando
		sub t0, t0, t4		# Reinicia o endere?o vga para o primeiro pixel da linha
		li t4, 0		# Reinicia o iterador de coluna
		addi t5, t5, 1		# Incrementa iterador de linha
		addi t0, t0, 320	# Pr?xima linha na mem?ria vga
		j drawLoop
	continueLine:
		lw t6, 0(t1)			# Carrega pixel da imagem
		li s0, 0xFF00FF			# Cor Magente (Transparente)
		beq t6, s0, transparent		# N?o desenha o pixel transparente
		sw t6, 0(t0)			# Escreve pixel na mem?ria vga
	transparent:
		addi t0, t0, 4			# Pr?ximo endere?o da mem?ria vga
		addi t1, t1, 4			# Pr?ximo pixel da imagem
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
	beq t1,t2,cf_fora	# Se for o ?ltimo endere?o ent?o sai do loop
	sw t3,0(t1)		# escreve a word na mem?ria VGA
	addi t1,t1,4		# soma 4 ao endere?o
	j cf_loop
cf_fora:	
.end_macro
.macro calculaPosicao(%rel_x, %rel_y, %base_x, %base_y)  
	# Caso geral do calcula posicao
	mv a0, %rel_x
	mv a1, %rel_y
	li t1, %base_x   
	li t2, %base_y
	mul t2, a1, t2
	add a0, t1, t2   # a0 armazena a coordenada x
	li t2, %base_y
	addi a1, a1, 1
	mul a1, a1, t2	# a1 armazena a coordenada y 
	ret
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
.include "imagens\esqueleto.data"
.include "imagens\mapa_1.data"
.include "imagens\mapa2.data"
.include "imagens\f1_b1.data"
.include "imagens\f1_b2.data"
.include "imagens\f1_b3.data"
.include "imagens\f1_b4.data"
.include "imagens\f2_b1.data"
.include "imagens\f2_b2.data"
.include "imagens\f2_b3.data"
.include "imagens\f2_b4.data"
.include "imagens\fase_1PrimeiraEscolhaErrada.data"
.include "imagens\fase_1PrimeiraEscolhaCerta.data"
.include "imagens\Justice_firstWrongAnswern.data"
.include "imagens\Justice_firstRightAnswern.data"
.include "imagens\Malina_background.data"
.include "imagens\Justice_background.data"
.include "imagens\tampao_mapa_1.data"
.include "imagens\pedra.data"
.include "imagens\malina.data"
.include "colisao_fase_1.data"
.include "colisao_fase_2.data"
screen_width:	.word 320
screen_height:	.word 240

frame_zero: .word 0xFF000000
frame_one:  .word 0xFF100000

hero_x: .byte 3
hero_y: .byte 3

# Incluindo ecalls customizadas
#.include "MACROSv21.s"
#.include "SYSTEMv21.s"

.text
#==============================================================================
# Main Program ================================================================
#==============================================================================
j fase2_teste

mainLoop:

# Drawing Menu ================================================================

# Menu Background
	drawImage(frame_zero,helltaker_menu,0,0)		# Desenha plano de fundo no frame_zero
	drawImage(frame_one,helltaker_menu,0,0)		# Desenhando plano de fundo no frame_one
# Menu Botoes
drawButtons:
	#jal checkEnd
	
	drawImage(frame_zero,novo_jogo_alto_1,80,140)	    # Desenha bot?o superior no frame_zero
	drawImage(frame_zero,sair_baixo_1,85,190)		    # Desenha bot?o inferior no frame_zero
	
	
	drawImage(frame_one,novo_jogo_baixo_1,85,140)	 # Desenha bot?o superior no frame_one
	drawImage(frame_one,sair_alto_1,80,190)		# Desenha bot?o inferior no frame_one
	
selecaoMenuInicial:
	jal readKeyBlocking				# L? input do usu?rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c?digo ascii da tecla enter em t2
	beq a0,t2,menuInicialSelecionado		# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,mudarSelecao				# Se w for selecionado, muda sele??o
	beq a0,t0,mudarSelecao				# Se s for selecionado, muda sele??o
	j loopMenu 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
mudarSelecao:
	jal changeFrame					# Muda tela
loopMenu:
	j selecaoMenuInicial				#Reitera o loop
	
menuInicialSelecionado:
	drawImage(frame_one,backgroundchatBelzebub,0,0)  # Desenha o background do di?logo no frame 1
	drawImage(frame_zero,backgroundchatBelzebub,0,0) # Desenha o background do di?logo no frame o
	drawImage(frame_zero,PrimeirochatBelzebub,0,136) # Desenha o primeiro di?logo no frame 0
	drawImage(frame_one,SegundochatBelzebub,0,136)   # Desenha o segundo di?logo no frame 1
	jal readKeyBlocking				# Se o usu?rio apertar alguma tecla, mostra o pr?ximo frame
	jal changeFrame					
	jal readKeyBlocking				# Se o usu?rio apertar alguma ecla, segue o jogo (no caso, mostra o mapa)

# Primeira Fase
fase1_teste:
	clearFrame(frame_zero)			# Limpa os frames
	clearFrame(frame_one)
	drawImage(frame_zero, mapa_1, 70, 20)	# Desenha o mapa no Frame 0
	drawImage(frame_one, mapa_1, 70, 20)	# Desenha o mapa no Frame 1
	drawImage(frame_zero, pedra, 130, 100)	# Desenha o mapa no Frame 0
	drawImage(frame_one, pedra,130, 100)	# Desenha o mapa no Frame 1
	drawImage(frame_zero, pedra, 170, 80)	# Desenha o mapa no Frame 0
	drawImage(frame_one, pedra,170, 80)	# Desenha o mapa no Frame 1
	drawImage(frame_zero, pedra, 190, 80)	# Desenha o mapa no Frame 0
	drawImage(frame_one, pedra,190, 80)	# Desenha o mapa no Frame 1
	drawImage(frame_zero, malina, 170, 40)	# Desenha o mapa no Frame 0
	drawImage(frame_one, malina,170, 40)	# Desenha o mapa no Frame 1
	li a3, 3 				# Marca o posicionamento inincial do eixo x do her?i
	li a6, 3 				# Marca o posicionamento inincial do eixo y do her?i
	li s3, 6				# Marca o eixo x do ponto que abre a caixa de dialogo
	li s6, 2			        # Marca o eixo y do ponto que abre a caixa de dialogo
	jal calculaPosicao
	drawImageNotImm(frame_zero, hero, t1, t2)	# Desenha o Helltaker na posi??o inicial (3, 3)
	jal calculaPosicao
	drawImageNotImm(frame_one, hero, t1, t2)	# Desenha o Helltaker na posi??o inicial (3, 3)


fase_1:
	beq a3, s3, fase_1DialogCase
fase_1AfterComparison:
	jal readKeyNonBlocking			# l? input do usu?rio	
	li t0, 'w'				# armazena c?digo da letra w em t0
	beq a0, t0 , moveParaCima		# Se input for w, roda o comando de mover para cima
	li t0, 'a'
	beq a0, t0, moveParaEsquerda
	li t0, 's'
	beq a0, t0, moveParaBaixo
	li t0, 'd'
	beq a0, t0, moveParaDireita
	j fase_1					# Se n?o for, checa o caso do input ser a
moveParaCima:
	jal calculaPosicao
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)
	addi a6, a6, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_fase_1
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, cimaLivre
	addi a6, a6, 1
cimaLivre:
	jal calculaPosicao
	drawImageNotImm(frame_zero, hero, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, hero, t1, t2)
	j fase_1
moveParaEsquerda:	
	jal calculaPosicao
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)
	addi a3, a3, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_fase_1
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, esquerdaLivre
	addi a3, a3, 1
esquerdaLivre:
	jal calculaPosicao
	drawImageNotImm(frame_zero, hero, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, hero, t1, t2)
	j fase_1			# Reitera o loop
moveParaBaixo:
	jal calculaPosicao
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)
	addi a6, a6, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_fase_1
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, baixoLivre
	addi a6, a6, -1
baixoLivre:
	jal calculaPosicao
	drawImageNotImm(frame_zero, hero, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, hero, t1, t2)
	j fase_1			# Reitera o loop
moveParaDireita:
	jal calculaPosicao
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)
	addi a3, a3, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_fase_1
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, direitaLivre
	addi a3, a3, -1
direitaLivre:
	jal calculaPosicao
	drawImageNotImm(frame_zero, hero, t1, t2)
	jal calculaPosicao
	drawImageNotImm(frame_one, hero, t1, t2)
	j fase_1			# Reitera o loop
fase_1DialogCase:
	beq a6,s6,fase_1AbreDialogo
	j fase_1AfterComparison
fase_1AbreDialogo:
	drawImage(frame_zero,Malina_background,0,0)		# Desenha plano de fundo no frame_zero
	drawImage(frame_one,Malina_background,0,0)		# Desenhando plano de fundo no frame_one

fase_1DrawOptions:
	
	
	drawImage(frame_zero,f1_b1,10,135)	    # Desenha botao superior no frame_zero
	drawImage(frame_zero,f1_b4,4,185)		    # Desenha botao inferior no frame_zero
	
	
	drawImage(frame_one,f1_b2,4,135)	 # Desenha botao superior no frame_one
	drawImage(frame_one,f1_b3,10,185)		# Desenha bota0 inferior no frame_one
	
fase_1UserChoice:
	jal readKeyBlocking				# L? input do usu?rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c?digo ascii da tecla enter em t2
	beq a0,t2,fase1_userChoose				# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,fase_1ChangeChoice				# Se w for selecionado, muda sele??o
	beq a0,t0,fase_1ChangeChoice			# Se s for selecionado, muda sele??o
	j loopMenu 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
fase_1ChangeChoice:
	jal changeFrame					# Muda tela
fase_1ChoicLoop:
	j fase_1UserChoice				#Reitera o loop

fase1_userChoose:
	bne a5,zero,fase_1RightChoice
	drawImage(frame_zero,fase_1PrimeiraEscolhaErrada,0,0)
	jal changeFrame
	jal readKeyBlocking
	j fase1_teste
fase_1RightChoice:
	drawImage(frame_zero,fase_1PrimeiraEscolhaCerta,0,0)
	jal changeFrame
	jal readKeyBlocking
	
# Primeira Fase
fase2_teste:
	clearFrame(frame_zero)			# Limpa os frames
	clearFrame(frame_one)
	drawImage(frame_zero, mapa2, 70, 20)	# Desenha o mapa no Frame 0
	drawImage(frame_one, mapa2, 70, 20)	# Desenha o mapa no Frame 1
	drawImage(frame_zero, pedra, 174, 100)	
	drawImage(frame_one, pedra,174, 100)	
	drawImage(frame_zero, pedra, 194, 100)	#Desenha blocos nos dois frames
	drawImage(frame_one, pedra,194, 100)
	drawImage(frame_zero, pedra, 174, 140)	
	drawImage(frame_one, pedra,174, 140)	
	drawImage(frame_zero, pedra, 214, 140)	
	drawImage(frame_one, pedra,214, 140)		
	# Desenhando os Esqueletos no Mapa
	li s11, 0	# Primeiro quadrado do mapa

desenha_esqueletos:
	li t1, 89	# Último quadrado do mapa
	bgt s11, t1, plotaHeroi2

	li t2, 'E'
	la t3, colisao_fase_2
	add t3, t3, s11
	lb t4, 0(t3)
	bne t4, t2, nao_desenha_esqueleto
		li t3, 10
		rem a3, s11, t3
		div a6, s11, t3
		jal calculaPosicaoFase2
		drawImageNotImm(frame_zero, esqueleto, t1, t2)
		jal calculaPosicaoFase2
		drawImageNotImm(frame_one, esqueleto, t1, t2)
nao_desenha_esqueleto:	
	addi s11, s11, 1
	j desenha_esqueletos
plotaHeroi2:
	li a3, 1				# Marca o posicionamento inincial do eixo x do her?i
	li a6, 6 				# Marca o posicionamento inincial do eixo y do her?i
	li s3, 6				# Marca o eixo x do ponto que abre a caixa de dialogo
	li s6, 7			        # Marca o eixo y do ponto que abre a caixa de dialogo
	jal calculaPosicaoFase2
	drawImageNotImm(frame_zero, hero, t1, t2)	# Desenha o Helltaker na posi??o inicial (3, 3)
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, hero, t1, t2)	# Desenha o Helltaker na posi??o inicial (3, 3)

fase_2:
	beq a3, s3, fase_2DialogCase
fase_2AfterComparison:
	jal readKeyNonBlocking			# l? input do usu?rio	
	li t0, 'w'				# armazena c?digo da letra w em t0
	beq a0, t0 , moveParaCima2		# Se input for w, roda o comando de mover para cima
	li t0, 'a'
	beq a0, t0, moveParaEsquerda2
	li t0, 's'
	beq a0, t0, moveParaBaixo2
	li t0, 'd'
	beq a0, t0, moveParaDireita2
	j fase_2					# Se n?o for, checa o caso do input ser a
moveParaCima2:
	jal calculaPosicaoFase2
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)
	addi a6, a6, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_fase_2
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoCima
	addi a6, a6, 1
checaEsqueletoCima:
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, cimaLivre2			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueleto		# Se esweuelto estiver encurralado, ele morre
	sb t0, -10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	jal calculaPosicaoFase2					# Desenha o tampão onde estava o esqueleto	
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)	
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)

	addi a6, a6, -1						# Sobe uma posição na matriz
	jal calculaPosicaoFase2					# Desenha o esqueleto
	drawImageNotImm(frame_zero, esqueleto, t1, t2)	
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, esqueleto, t1, t2)	
	addi a6, a6, 1						# Corrige a posição de volta para o personagem
MorteDoEsqueleto:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	jal calculaPosicaoFase2					# Desenha o tampão onde estava o esqueleto	
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)	
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)	
cimaLivre2:
	jal calculaPosicaoFase2
	drawImageNotImm(frame_zero, hero, t1, t2)
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, hero, t1, t2)
	j fase_2
moveParaEsquerda2:
	jal calculaPosicaoFase2
	drawImageNotImm(frame_zero, tampao_mapa_1, t1, t2)
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, tampao_mapa_1, t1, t2)
	addi a3, a3, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_fase_2
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, esquerdaLivre2
	addi a3, a3, 1
esquerdaLivre2:
	jal calculaPosicaoFase2
	drawImageNotImm(frame_zero, hero, t1, t2)
	jal calculaPosicaoFase2
	drawImageNotImm(frame_one, hero, t1, t2)
	j fase_2			# Reitera o loop
moveParaBaixo2:
	jal calculaPosicaoFase2

	la a0, tampao_mapa_1
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	jal calculaPosicaoFase2

	la a0, tampao_mapa_1
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm


	addi a6, a6, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)

	li t0, 'X'
	la t1, colisao_fase_2
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoBaixo
	addi a6, a6, -1

checaEsqueletoBaixo:
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, BaixoLivre2		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoBx		# Se esweuelto estiver encurralado, ele morre
	sb t0, 10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	jal calculaPosicaoFase2					# Desenha o tampão onde estava o esqueleto	

	la a0, tampao_mapa_1
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	jal calculaPosicaoFase2
	
	la a0, tampao_mapa_1
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	addi a6, a6, 1						# Sobe uma posição na matriz
	jal calculaPosicaoFase2					# Desenha o esqueleto

	la a0, esqueleto
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	jal calculaPosicaoFase2

	la a0, esqueleto
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	addi a6, a6, -1						# Corrige a posição de volta para o personagem
MorteDoEsqueletoBx:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	jal calculaPosicaoFase2					# Desenha o tampão onde estava o esqueleto	

	la a0, tampao_mapa_1
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm	

	jal calculaPosicaoFase2

	la a0, tampao_mapa_1
	lw t0, frame_one			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm
BaixoLivre2:
	jal calculaPosicaoFase2

	la a0, hero
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm	
	jal calculaPosicaoFase2
	la a0, hero
	lw t0, frame_one			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm
	j fase_2
moveParaDireita2:
	jal calculaPosicaoFase2

	la a0, tampao_mapa_1
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	jal calculaPosicaoFase2

	la a0, tampao_mapa_1
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm


	addi a3, a3, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)

	li t0, 'X'
	la t1, colisao_fase_2
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoDireita
	addi a3, a3, -1

checaEsqueletoDireita:
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, DireitaLivre2		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 1(t1)				#Armazena o quadrado a direita do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoDir		# Se esweuelto estiver encurralado, ele morre
	sb t0, 1(t1)				# Se for esqueleto, muda a memória do quadrado do lado para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	jal calculaPosicaoFase2					# Desenha o tampão onde estava o esqueleto	

	la a0, tampao_mapa_1
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	jal calculaPosicaoFase2
	
	la a0, tampao_mapa_1
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	addi a3, a3, 1						# Sobe uma posição na matriz
	jal calculaPosicaoFase2					# Desenha o esqueleto

	la a0, esqueleto
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	jal calculaPosicaoFase2

	la a0, esqueleto
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm

	addi a3, a3, -1						# Corrige a posição de volta para o personagem
MorteDoEsqueletoDir:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	jal calculaPosicaoFase2					# Desenha o tampão onde estava o esqueleto	

	la a0, tampao_mapa_1
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm	

	jal calculaPosicaoFase2

	la a0, tampao_mapa_1
	lw t0, frame_one			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm
DireitaLivre2:
	jal calculaPosicaoFase2

	la a0, hero
	lw t0, frame_zero			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm	
	jal calculaPosicaoFase2
	la a0, hero
	lw t0, frame_one			
	add a1,zero,t1
	add a2,zero, t2

	jal drawImageNotImm
	j fase_2

	
fase_2DialogCase:
	beq a6,s6,fase_2AbreDialogo
	j fase_2AfterComparison
fase_2AbreDialogo:
	drawImage(frame_zero,Justice_background,0,0)		# Desenha plano de fundo no frame_zero
	drawImage(frame_one,Justice_background,0,0)		# Desenhando plano de fundo no frame_one

fase_2DrawOptions:
	
	
	drawImage(frame_zero,f2_b2,4,135)	    # Desenha botao superior no frame_zero
	drawImage(frame_zero,f2_b1,4,185)		    # Desenha botao inferior no frame_zero
	
	
	drawImage(frame_one,f2_b3,4,135)	 # Desenha botao superior no frame_one
	drawImage(frame_one,f2_b4,4,185)		# Desenha bota0 inferior no frame_one
	
fase_2UserChoice:
	jal readKeyBlocking				# L? input do usu?rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c?digo ascii da tecla enter em t2
	beq a0,t2,fase2_userChoose				# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,fase_2ChangeChoice				# Se w for selecionado, muda sele??o
	beq a0,t0,fase_2ChangeChoice			# Se s for selecionado, muda sele??o
	j loopMenu 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
fase_2ChangeChoice:
	jal changeFrame					# Muda tela
fase_2ChoicLoop:
	j fase_2UserChoice				#Reitera o loop

fase2_userChoose:
	bne a5,zero,fase_2RightChoice
	drawImage(frame_zero,Justice_firstWrongAnswern,0,0)
	jal changeFrame
	jal readKeyBlocking
	j fase2_teste
fase_2RightChoice:
	drawImage(frame_zero,Justice_firstRightAnswern,0,0)
	jal changeFrame
	jal readKeyBlocking

# Fim do Programa
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
# Pausa o programa e espera que o usu?rio pressione uma tecla para continuar
#
# caractere pressiona -> a0
	
	li t1, 0xFF200000		# Carrega o endere?o de status do KDMMIO
rkb_loop:
	lw t0, 0(t1)		# Carrega o status do teclado
	andi t0, t0, 0x0001	# Mascara o bit menos significativo. Por qu??!
	beq t0, zero, rkb_loop	# Se n?o houver tecla pressionada repete at? que o usu?rio aperte algo
	lw a0, 4(t1)			# Carrega o caractere que foi pressionado
	sw a0, 12(t1)			# Escreve o caractere lido no display 
	ret
		

readKeyNonBlocking:
# Verifica se o usu?rio pressionou uma tecla, se n?o continua o programa, se
# sim, retorna o caractere pressionado
#
# caractere -> a0
	
	li t1, 0xFF200000	# Carrega o endere?o de status do KDMMIO
	lw t0, 0(t1)		# Carrega o status do teclado
	andi t0, t0, 0x0001	# Mascara o bit menos significativo. Por qu??!
	beq t0, zero, rknb_end	# Se n?o houver tecla pressionada continua
	lw t2, 4(t1)		# Carrega o caractere que foi pressionado
	lw a0, 4(t1)		# Carrega em a0 (vari?vel de retorno) o caractere
	sw t2, 12(t1)		# Escreve o caractere lido no display
rknb_end:
	ret
	

changeFrame:	
	xori a5,a5,1
	li t0, 0xFF200604
	sw a5, 0(t0)	
	ret

calculaPosicao:  # baseado em a3 e a4, armazena em t1 e t2 as coordenadas em pixels da posi??o atual do personagem
	li t1,70   
	li t2, 20
	mul t2, t2, a3 
	add t1, t1, t2   # t1 armazena a coordenada x
	li t2, 20
	addi t5, a6,1
	mul t2, t2,t5	#t2 armazena a coordenada y 
	ret
	
calculaPosicaoFase2:  # baseado em a3 e a4, armazena em t1 e t2 as coordenadas em pixels da posi??o atual do personagem
	li t1,74
	li t2, 20
	mul t2, t2, a3 
	add t1, t1, t2   # t1 armazena a coordenada x
	li t2, 20
	addi t5, a6,1
	mul t2, t2,t5	#t2 armazena a coordenada y 
	ret
	
desenhaHeroiFrameEscondido:
	xori t4,a5,1                               
	beq t4,zero,HeroiFrameZeroEscondido
	j HeroiFrameOneEscondido
HeroiFrameZeroEscondido:
	drawImageNotImm(frame_zero,hero,t1,t2)
	ret
HeroiFrameOneEscondido:
	drawImageNotImm(frame_one,hero,t1,t2)
	ret

desenhaTampaoFrameEscondido:
	xori t4,a5,1
	beq t4,zero,TampaoFrameZeroEscondido
	j TampaoFrameOneEscondido
TampaoFrameZeroEscondido:
	drawImageNotImm(frame_zero,tampao_mapa_1,t1,t2)
	ret
TampaoFrameOneEscondido:
	drawImageNotImm(frame_one,tampao_mapa_1,t1,t2)
	ret
	
drawImageNotImm:				#Procedimento do drawImage
# Desenha uma figura de qualquer tamanho na tela de bitmap
#
# a0: imagem
# a1: coordenada x
# a2: coordenada y
	#la a0, %imagem
	#lw t0, %frame			# Endereco da memoria vga
	#add a1,zero,%coord_x
	#add a2,zero, %coord_y
	lw t1, screen_width		# Carrega largura da tela
	mul t1, t1, a2			# Multiplica largura pela coordenada y
	add t0, t0, t1			# Adiciona multiplicacao ao endereco do frame
	add t0, t0, a1			# Adiciona a coordenada x ao endere?o do frame
	li t2, 4			# Carrega o tamanho de uma word na mem?ria
	rem t1, t0, t2			# Calcula o resto entre o endere?o da vga e 4
	beqz t1, gridOk			# Se n?o for divis?vel por 4 dara problema de desalinhamento de endere?amento da mem?ria
	sub t0, t0, t1			# Nesse caso, escolhe o endere?o v?lido imediatamente ? esquerda
gridOk:
	add t1, zero, a0		# Endere?o da imagem
	lw t2, 0(t1)			# Largura da imagem
	lw t3, 4(t1)			# Altura da imagem
	addi t1, t1, 8			# Muda t1 para o primeiro pixel da imagem, ap?s informa??es de altura e largura
	li t4, 0			# Iterador de colunas
	li t5, 0			# Iterador de linhas
drawLoop:	
	beq t5, t3, endDraw		# Verifica se desenhou todas as linhas da imagem
	blt t4, t2, continueLine	# Se n?o chegou ao final da linha continua desenhando
	sub t0, t0, t4		# Reinicia o endere?o vga para o primeiro pixel da linha
	li t4, 0		# Reinicia o iterador de coluna
	addi t5, t5, 1		# Incrementa iterador de linha
	addi t0, t0, 320	# Pr?xima linha na mem?ria vga
	j drawLoop
continueLine:
	lw t6, 0(t1)			# Carrega pixel da imagem
	li s0, 0xFF00FF			# Cor Magente (Transparente)
	beq t6, s0, transparent		# N?o desenha o pixel transparente
	sw t6, 0(t0)			# Escreve pixel na mem?ria vga
transparent:
	addi t0, t0, 4			# Pr?ximo endere?o da mem?ria vga
	addi t1, t1, 4			# Pr?ximo pixel da imagem
	addi t4, t4, 4			# Incrementa iterador			
	j drawLoop
endDraw:
	li a0, 0			# Limpa o registro pra retornar
	li a1, 0			# Limpa o registro pra retornar
	li a2, 0			# Limpa o registro pra retornar
	ret

	
