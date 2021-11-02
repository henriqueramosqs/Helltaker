###############################################################################
##                                 HELLTAKER                                ##
##############################################################################
# Incluindo ecalls customizadas
.include "MACROSv21.s"
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
.include "imagens\hero_kick.data"
.include "imagens\hero_hurt.data"
.include "imagens\esqueleto.data"
.include "imagens\mapa_1.data"
.include "imagens\mapa2.data"
.include "imagens\mapa3.data"
.include "imagens\mapa4.data"
.include "imagens\f1_b1.data"
.include "imagens\f1_b2.data"
.include "imagens\f1_b3.data"
.include "imagens\f1_b4.data"
.include "imagens\f2_b1.data"
.include "imagens\f2_b2.data"
.include "imagens\f2_b3.data"
.include "imagens\f2_b4.data"
.include "imagens\f3_b1.data"
.include "imagens\f3_b2.data"
.include "imagens\f3_b3.data"
.include "imagens\f3_b4.data"
.include "imagens\fase_1PrimeiraEscolhaErrada.data"
.include "imagens\fase_1PrimeiraEscolhaCerta.data"
.include "imagens\Justice_firstWrongAnswern.data"
.include "imagens\Justice_firstRightAnswern.data"
.include "imagens\Malina_background.data"
.include "imagens\Justice_background.data"
.include "imagens\cerberusBackground.data"
.include "imagens\tampao.data"
.include "imagens\pedra.data"
.include "imagens\cerberusFirstWrongAnswern.data"
.include "imagens\cerberusFirsRightAnswern.data"
.include "imagens\espinho.data"
.include "imagens\malina.data"
.include "imagens\Fase2Morte.data"
.include "imagens\Fase3Morte.data"
.include "imagens\justice.data"
.include "colisao_fase_1.data"
.include "colisao_fase_2.data"
.include "colisao_fase_3.data"
.include "colisao_fase_4.data"
.include "imagens\Fase4Morte.data"
.include "imagens\zdradaBackground1.data"
.include "imagens\zdradaBackground2.data"
.include "imagens\ZdradaFirstWrongAnswern.data"
.include "imagens\ZdradaSecondRightAnswern.data"
.include "imagens\ZdradaSecondWrongAnswern.data"
.include "imagens\f4_b1.data"
.include "imagens\f4_b2.data"
.include "imagens\f4_b3.data"
.include "imagens\f4_b4.data"
.include "imagens\f4_b5.data"
.include "imagens\f4_b6.data"
.include "imagens\f4_b7.data"
.include "imagens\f4_b8.data"
.include "imagens\chave.data"
.include "imagens\bau.data"

screen_width:	.word 320
screen_height:	.word 240

frame_zero: .word 0xFF000000
frame_one:  .word 0xFF100000
movRest:.string "Movimentos restantes: " 

colisao_temporaria: .byte 0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,
			  0,0,0,0,0,0,0,0,0,0,



.text
#==============================================================================
# Main Program ================================================================
#==============================================================================

j fase4

mainLoop:

# Drawing Menu ================================================================

# Menu Background
	la a0, helltaker_menu
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	la a0, helltaker_menu
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	
# Menu Botoes
drawButtons:
	#jal checkEnd
	
	la a0, novo_jogo_alto_1
	li a1, 80
	li a2, 140
	lw t0, frame_one
	jal drawImage
	la a0, sair_baixo_1
	li a1, 85
	li a2, 190
	lw t0, frame_one
	jal drawImage
	
	la a0, novo_jogo_baixo_1
	li a1, 85
	li a2, 140
	lw t0, frame_zero
	jal drawImage
	la a0, sair_alto_1
	li a1, 80
	li a2, 190
	lw t0, frame_zero
	jal drawImage
	
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
	la a0, backgroundchatBelzebub
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	la a0, backgroundchatBelzebub
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	la a0, PrimeirochatBelzebub
	li a1, 0
	li a2, 136
	lw t0, frame_zero
	jal drawImage
	la a0, SegundochatBelzebub
	li a1, 0
	li a2, 136
	lw t0, frame_zero
	jal drawImage
	jal readKeyBlocking				# Se o usu?rio apertar alguma tecla, mostra o pr?ximo frame
	jal changeFrame					
	jal readKeyBlocking				# Se o usu?rio apertar alguma ecla, segue o jogo (no caso, mostra o mapa)

# Primeira Fase
fase1:
	jal clearFrames
	#clearFrame(frame_zero)			# Limpa os frames
	#clearFrame(frame_one)
	la a0, mapa_1
	li a1, 74
	li a2, 20
	lw t0, frame_zero
	jal drawImage
	la a0, mapa_1
	li a1, 74
	li a2, 20
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero, mapa_1, 70, 20)	# Desenha o mapa no Frame 0
	#drawImage(frame_one, mapa_1, 70, 20)	# Desenha o mapa no Frame 1
	la a0, pedra
	li a1, 130
	li a2, 100
	lw t0, frame_zero
	jal drawImage
	la a0, pedra
	li a1, 130
	li a2, 100
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero, pedra, 130, 100)	# Desenha o mapa no Frame 0
	#drawImage(frame_one, pedra,130, 100)	# Desenha o mapa no Frame 1
	la a0, pedra
	li a1, 170
	li a2, 80
	lw t0, frame_zero
	jal drawImage
	la a0, pedra
	li a1, 170
	li a2, 80
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero, pedra, 170, 80)	# Desenha o mapa no Frame 0
	#drawImage(frame_one, pedra,170, 80)	# Desenha o mapa no Frame 1
	la a0, pedra
	li a1, 190
	li a2, 80
	lw t0, frame_zero
	jal drawImage
	la a0, pedra
	li a1, 190
	li a2, 80
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero, pedra, 190, 80)	# Desenha o mapa no Frame 0
	#drawImage(frame_one, pedra,190, 80)	# Desenha o mapa no Frame 1
	la a0, malina
	li a1, 170
	li a2, 40
	lw t0, frame_zero
	jal drawImage
	la a0, malina
	li a1, 170
	li a2, 40
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero, malina, 170, 40)	# Desenha o mapa no Frame 0
	#drawImage(frame_one, malina,170, 40)	# Desenha o mapa no Frame 1
	li a3, 3 				# Marca o posicionamento inincial do eixo x do her?i
	li a6, 3 				# Marca o posicionamento inincial do eixo y do her?i
	li s3, 6				# Marca o eixo x do ponto que abre a caixa de dialogo
	li s6, 2			        # Marca o eixo y do ponto que abre a caixa de dialogo
	jal calculaPosicaoFase2	
	la a0, hero
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, hero
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm


fase1_loop:
	beq a3, s3, fase_1DialogCase
fase_1AfterComparison:
	jal readKeyNonBlocking			# l? input do usu?rio	
	li t0, 'w'				# armazena c?digo da letra w em t0
	beq a0, t0 , moveCima1		# Se input for w, roda o comando de mover para cima
	li t0, 'a'
	beq a0, t0, moveEsquerda1
	li t0, 's'
	beq a0, t0, moveBaixo1
	li t0, 'd'
	beq a0, t0, moveDireita1
	j fase1_loop					# Se n?o for, checa o caso do input ser a
moveCima1:
	jal calculaPosicaoFase2	
	la a0, tampao
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, tampao
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
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
	jal calculaPosicaoFase2	
	la a0, hero
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, hero
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	j fase1_loop
moveEsquerda1:	
	jal calculaPosicaoFase2	
	la a0, tampao
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, tampao
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
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
	jal calculaPosicaoFase2	
	la a0, hero
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, hero
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	j fase1_loop			# Reitera o loop
moveBaixo1:
	jal calculaPosicaoFase2	
	la a0, tampao
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, tampao
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
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
	jal calculaPosicaoFase2	
	la a0, hero
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, hero
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	j fase1_loop			# Reitera o loop
moveDireita1:
	jal calculaPosicaoFase2	
	la a0, tampao
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, tampao
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	addi a3, a3, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_fase_1
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaPedraDir1
	addi a3, a3, -1
	j direitaLivre
checaPedraDir1:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, direitaLivre			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, 1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir1		# Se pedra estiver apoiada, não move
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir1		# Se pedra estiver apoiada, não move
	sb t0, 1(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	jal calculaPosicaoFase2	
	la a0, tampao
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	jal calculaPosicaoFase2
	la a0, tampao
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	addi a3, a3, 1
	jal calculaPosicaoFase2	
	la a0, pedra
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	jal calculaPosicaoFase2
	la a0, pedra
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	addi a3, a3, -2
	j direitaLivre
	
naoMovePedraDir1:	
	addi a3, a3, -1						# Corrige a posição de volta para o personagem
direitaLivre:
	jal calculaPosicaoFase2	
	la a0, hero
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, hero
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	j fase1_loop			# Reitera o loop
fase_1DialogCase:
	beq a6,s6,fase_1AbreDialogo
	j fase_1AfterComparison
fase_1AbreDialogo:
	la a0, Malina_background
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	la a0, Malina_background
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero,Malina_background,0,0)		# Desenha plano de fundo no frame_zero
	#drawImage(frame_one,Malina_background,0,0)		# Desenhando plano de fundo no frame_one

fase_1DrawOptions:
	
	la a0, f1_b1
	li a1, 10
	li a2, 135
	lw t0, frame_zero
	jal drawImage
	la a0, f1_b4
	li a1, 4
	li a2, 185
	lw t0, frame_zero
	jal drawImage
	#drawImage(frame_zero,f1_b1,10,135)	    # Desenha botao superior no frame_zero
	#drawImage(frame_zero,f1_b4,4,185)		    # Desenha botao inferior no frame_zero
	
	la a0, f1_b2
	li a1, 4
	li a2, 135
	lw t0, frame_one
	jal drawImage
	la a0, f1_b3
	li a1, 10
	li a2, 185
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_one,f1_b2,4,135)	 # Desenha botao superior no frame_one
	#drawImage(frame_one,f1_b3,10,185)		# Desenha bota0 inferior no frame_one
	
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
	la a0, fase_1PrimeiraEscolhaErrada
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	#drawImage(frame_zero,fase_1PrimeiraEscolhaErrada,0,0)
	jal changeFrame
	jal readKeyBlocking
	j fase1
fase_1RightChoice:
	la a0, fase_1PrimeiraEscolhaCerta
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	#drawImage(frame_zero,fase_1PrimeiraEscolhaCerta,0,0)
	jal changeFrame
	jal readKeyBlocking
	
# Segunda Fase
fase2:
	jal clearFrames
	#clearFrame(frame_zero)			# Limpa os frames
	#clearFrame(frame_one)
	la a0, mapa2
	li a1, 70
	li a2, 20
	lw t0, frame_zero
	jal drawImage
	la a0, mapa2
	li a1, 70
	li a2, 20
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero, mapa2, 70, 20)	# Desenha o mapa no Frame 0
	#drawImage(frame_one, mapa2, 70, 20)	# Desenha o mapa no Frame 1
	
	li a3, 5
	li a6, 7
	jal calculaPosicaoFase2	
	la a0, justice
	lw t0, frame_zero			# Endereco da memoria vga
	mv a1, t1
	mv a2, t2
	jal drawImageNotImm
	li a3, 5
	li a6, 7
	jal calculaPosicaoFase2	
	la a0, justice
	lw t0, frame_one			# Endereco da memoria vga
	mv a1, t1
	mv a2, t2
	jal drawImageNotImm
	
# Salvando a colisão em um novo local da memória para não afetar a original
	li s11, 0		# Primeiro quadrado do mapa
	la a0, colisao_fase_2	# Escolhe o arquivo de colisao da fase
	jal s9, copiaColisao
# Desenhando Pedras no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaPedras
# Desenhando Esqueletos no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaEsqueletos
# Desenhando Espinhos no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaEspinhos
# Desenhando o Heroi
plotaHeroi2:
	li a3, 1				# Marca o posicionamento inincial do eixo x do her?i
	li a6, 6 				# Marca o posicionamento inincial do eixo y do her?i
	li s3, 6				# Marca o eixo x do ponto que abre a caixa de dialogo
	li s6, 7			        # Marca o eixo y do ponto que abre a caixa de dialogo
	
	la a4, hero
	jal s9, spriteNotImm

# Seta Contador de passos
	li s10, 24

fase2_loop:
	beq a3, s3, fase_2DialogCase
	ble s10, zero, fase2_morte
fase_2AfterComparison:
# Mostrando a vida na tela
	mv s9, a3
	mv a0, s10
	li t0, 10 
	
	blt a0, t0, digito_unico
	
	add t6,a0,zero
	li a7,104
	la a0,movRest
	li a1,2
	li a2,3
	li a3,255
	li a4,0
	ecall
	add a0, t6,zero
	
	li a1, 2
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
	j vida_continua
digito_unico:
	li a1, 10
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
	li a0, 0
	li a1, 2
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
vida_continua:
	mv a3, s9

# Checando teclas pressionadas
	jal readKeyNonBlocking			# l? input do usu?rio	
	li t0, 'w'				# armazena c?digo da letra w em t0
	beq a0, t0 , moveCima2		# Se input for w, roda o comando de mover para cima
	li t0, 'a'
	beq a0, t0, moveEsquerda2
	li t0, 's'
	beq a0, t0, moveBaixo2
	li t0, 'd'
	beq a0, t0, moveDireita2
	j fase2_loop					# Se n?o for, checa o caso do input ser a
moveCima2:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoCima
	addi a6, a6, 1
	j checaEspinhoCima2
checaEsqueletoCima:
	addi s10,s10,-1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraCima		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueleto		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueleto
	sb t0, -10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	la a4, tampao
	jal s9, spriteNotImm

	addi a6, a6, -1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm
	
	addi a6, a6, 2						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoCima2
MorteDoEsqueleto:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm

	addi a6, a6, 1
	
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3

	j checaEspinhoCima2
checaPedraCima:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoCima2			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraCima2		# Se pedra estiver apoiada, não move
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraCima2		# Se pedra estiver apoiada, não move
	sb t0, -10(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, -1
	la a4, pedra
	jal s9, spriteNotImm
	addi a6, a6, 2
	jal s11, animacaoChute
	j checaEspinhoCima2
naoMovePedraCima2:	
	addi a6, a6, 1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoCima2:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoCima2
	jal s11, animacaoFuro
	j cimaLivre2
deixaEspinhoCima2:
	addi a6, a6, 1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a6, a6, -1
	bne t2, t0, cimaLivre2
	addi a6, a6, 1
	
	la a4, espinho
	jal s9, spriteNotImm
	addi a6, a6, -1
cimaLivre2:
	la a4, hero
	jal s9, spriteNotImm
	j fase2_loop
moveEsquerda2:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoEsq2
	addi a3, a3, 1
	j checaEspinhoEsq2
checaEsqueletoEsq2:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraEsq2		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoEsq2		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueletoEsq2
	sb t0, -1(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a3, a3, -1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm	
	addi a3, a3, 2						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoEsq2
	
MorteDoEsqueletoEsq2:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, 1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoEsq2
checaPedraEsq2:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoEsq2			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraEsq2		# Se pedra estiver apoiada, não move
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraEsq2		# Se pedra estiver apoiada, não move
	sb t0, -1(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, -1
	la a4, pedra
	jal s9, spriteNotImm
	addi a3, a3, 2
	jal s11, animacaoChute
	j checaEspinhoEsq2
	
naoMovePedraEsq2:	
	addi a3, a3, 1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoEsq2:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoEsq2
	jal s11, animacaoFuro
	j esquerdaLivre2
deixaEspinhoEsq2:
	addi a3, a3, 1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a3, a3, -1
	bne t2, t0, esquerdaLivre2
	addi a3, a3, 1
	la a4, espinho
	jal s9, spriteNotImm
	addi a3, a3, -1
esquerdaLivre2:
	la a4, hero
	jal s9, spriteNotImm
	
	j fase2_loop	 		# Reitera o loop
moveBaixo2:
	#addi s10, s10, -1
	jal calculaPosicaoFase2
	
	la a4, tampao
	jal s9, spriteNotImm


	addi a6, a6, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)

	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoBaixo
	addi a6, a6, -1
	j checaEspinhoBaixo2
	
checaEsqueletoBaixo:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraBaixo2		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoBx		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueletoBx
	sb t0, 10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a6, a6, 1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm

	addi a6, a6, -2					# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoBaixo2
MorteDoEsqueletoBx:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	jal calculaPosicaoFase2					# Desenha o tampão onde estava o esqueleto	
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, -1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoBaixo2
	
checaPedraBaixo2:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoBaixo2			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraBaixo2		# Se pedra estiver apoiada, não move
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraBaixo2		# Se pedra estiver apoiada, não move
	sb t0, 10(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, 1
	la a4, pedra
	jal s9, spriteNotImm
	addi a6, a6, -2
	jal s11, animacaoChute
	j checaEspinhoBaixo2
naoMovePedraBaixo2:	
	addi a6, a6, -1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoBaixo2:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoBaixo2
	jal s11, animacaoFuro
	j BaixoLivre2
deixaEspinhoBaixo2:
	addi a6, a6, -1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a6, a6, 1
	bne t2, t0, BaixoLivre2
	addi a6, a6, -1
	la a4, espinho
	jal s9, spriteNotImm
	addi a6, a6, 1
BaixoLivre2:
	la a4, hero
	jal s9, spriteNotImm
	
	j fase2_loop
moveDireita2:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm

	addi a3, a3, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoDireita2
	addi a3, a3, -1
	j checaEspinhoDir2
	
checaEsqueletoDireita2:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraDir2		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 1(t1)				#Armazena o quadrado a direita do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoDir2		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoDir2		# Se esweuelto estiver encurralado, ele morre
	sb t0, 1(t1)				# Se for esqueleto, muda a memória do quadrado do lado para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a3, a3, 1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm
	addi a3, a3, -2					# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoDir2
MorteDoEsqueletoDir2:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, -1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoDir2
checaPedraDir2:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoDir2			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, 1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir2		# Se pedra estiver apoiada, não move
	lb t3, 1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir2		# Se pedra estiver apoiada, não move
	sb t0, 1(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, 1
	la a4, pedra
	jal s9, spriteNotImm
	addi a3, a3, -2
	jal s11, animacaoChute
	j checaEspinhoDir2
	
naoMovePedraDir2:	
	addi a3, a3, -1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoDir2:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoDir2
	jal s11, animacaoFuro
	j DireitaLivre2
deixaEspinhoDir2:
	addi a3, a3, -1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a3, a3, 1
	bne t2, t0, DireitaLivre2
	addi a3, a3, -1
	la a4, espinho
	jal s9, spriteNotImm
	addi a3, a3, 1
DireitaLivre2:
	la a4, hero
	jal s9, spriteNotImm
	
	j fase2_loop

fase2_morte:
	la a0, Fase2Morte
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	la a0,Fase2Morte
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	jal readKeyBlocking
	j fase2
fase_2DialogCase:
	beq a6,s6,fase_2AbreDialogo
	j fase_2AfterComparison
fase_2AbreDialogo:
# Sempre começar o diálogo na primeira opção
	li t0, 0xFF200604
	li t1, 0
	sw t1, 0(t0)
	
	la a0, Justice_background
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	la a0, f2_b2
	li a1, 4
	li a2, 135
	lw t0, frame_zero
	jal drawImage
	la a0, f2_b1
	li a1, 4
	li a2, 185
	lw t0, frame_zero
	jal drawImage
	
	la a0, Justice_background
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	la a0, f2_b3
	li a1, 4
	li a2, 135
	lw t0, frame_one
	jal drawImage
	la a0, f2_b4
	li a1, 4
	li a2, 185
	lw t0, frame_one
	jal drawImage

fase_2UserChoice:
	jal readKeyBlocking				# L? input do usu?rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c?digo ascii da tecla enter em t2
	beq a0,t2,fase2_userChoose				# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,fase_2ChangeChoice				# Se w for selecionado, muda sele??o
	beq a0,t0,fase_2ChangeChoice			# Se s for selecionado, muda sele??o
	j fase_2UserChoice 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
fase_2ChangeChoice:
	jal changeFrame					# Muda tela
fase_2ChoicLoop:
	j fase_2UserChoice				#Reitera o loop

fase2_userChoose:
	bne a5,zero,fase_2RightChoice
	la a0, Justice_firstWrongAnswern
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero,Justice_firstWrongAnswern,0,0)
	jal changeFrame
	jal readKeyBlocking
	jal clearFrames
	j fase2
fase_2RightChoice:
	la a0, Justice_firstRightAnswern
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero,Justice_firstRightAnswern,0,0)
	jal readKeyBlocking

# Terceira Fase
fase3:
	jal clearFrames
	#clearFrame(frame_zero)			# Limpa os frames
	#clearFrame(frame_one)
	la a0, mapa3
	li a1, 70
	li a2, 20
	lw t0, frame_zero
	jal drawImage
	la a0, mapa3
	li a1, 70
	li a2, 20
	lw t0, frame_one
	jal drawImage
		

        li a3, 8
	li a6, 7
	jal calculaPosicaoFase3	
	la a0, justice
	lw t0, frame_zero			# Endereco da memoria vga
	mv a1, t1
	mv a2, t2
	jal drawImageNotImm
	li a3, 8
	li a6, 7
	jal calculaPosicaoFase3	
	la a0, justice
	lw t0, frame_one			# Endereco da memoria vga
	mv a1, t1
	mv a2, t2
	jal drawImageNotImm
	
# Salvando a colisão em um novo local da memória para não afetar a original
	li s11, 0		# Primeiro quadrado do mapa
	la a0, colisao_fase_3	# Escolhe o arquivo de colisao da fase
	jal s9, copiaColisao
# Desenhando Pedras no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaPedras
# Desenhando Esqueletos no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaEsqueletos
# Desenhando Espinhos no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaEspinhos


# Desenhando o Heroi
plotaHeroi3:
	li a3, 7				# Marca o posicionamento inincial do eixo x do her?i
	li a6, 2 				# Marca o posicionamento inincial do eixo y do her?i
	li s3, 7				# Marca o eixo x do ponto que abre a caixa de dialogo
	li s6, 7			        # Marca o eixo y do ponto que abre a caixa de dialogo
	
	la a4, hero
	jal s9, spriteNotImm3

# Seta Contador de passos
	li s10, 26


fase3_loop:
	beq a3, s3, fase_3DialogCase
	ble s10, zero, fase3_morte
fase_3AfterComparison:
# Mostrando a vida na tela
	mv s9, a3
	mv a0, s10
	li t0, 10 
	
	blt a0, t0, digito_unico3
	
	add t6,a0,zero
	li a7,104
	la a0,movRest
	li a1,2
	li a2,3
	li a3,255
	li a4,0
	ecall
	add a0, t6,zero
	
	li a1, 2
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
	j vida_continua3
digito_unico3:
	li a1, 10
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
	li a0, 0
	li a1, 2
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
vida_continua3:
	mv a3, s9

# Checando teclas pressionadas
	jal readKeyNonBlocking			# l? input do usu?rio	
	li t0, 'w'				# armazena c?digo da letra w em t0
	beq a0, t0 , moveCima3		# Se input for w, roda o comando de mover para cima
	li t0, 'a'
	beq a0, t0, moveEsquerda3
	li t0, 's'
	beq a0, t0, moveBaixo3
	li t0, 'd'
	beq a0, t0, moveDireita3
	j fase3_loop					# Se n?o for, checa o caso do input ser a
moveCima3:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm3
	
	addi a6, a6, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoCima3
	addi a6, a6, 1
	j checaEspinhoCima3
checaEsqueletoCima3:
	addi s10,s10,-1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraCima3		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueleto3		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueleto
	sb t0, -10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	la a4, tampao
	jal s9, spriteNotImm

	addi a6, a6, -1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm
	
	addi a6, a6, 2						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoCima3
MorteDoEsqueleto3:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm3

	addi a6, a6, 1
	
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3

	j checaEspinhoCima3
checaPedraCima3:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoCima3			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraCima3		# Se pedra estiver apoiada, não move
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraCima3		# Se pedra estiver apoiada, não move
	sb t0, -10(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, -1
	la a4, pedra
	jal s9, spriteNotImm
	addi a6, a6, 2
	jal s11, animacaoChute
	j checaEspinhoCima3
naoMovePedraCima3:	
	addi a6, a6, 1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoCima3:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoCima3
	jal s11, animacaoFuro
	j cimaLivre3
deixaEspinhoCima3:
	addi a6, a6, 1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a6, a6, -1
	bne t2, t0, cimaLivre3
	addi a6, a6, 1
	
	la a4, espinho
	jal s9, spriteNotImm3
	addi a6, a6, -1
cimaLivre3:
	la a4, hero
	jal s9, spriteNotImm3
	j fase3_loop
moveEsquerda3:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm3
	
	addi a3, a3, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoEsq3
	addi a3, a3, 1
	j checaEspinhoEsq3
checaEsqueletoEsq3:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraEsq3		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoEsq3		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueletoEsq3
	sb t0, -1(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a3, a3, -1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm	
	addi a3, a3, 2						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoEsq3
	
MorteDoEsqueletoEsq3:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, 1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoEsq3
checaPedraEsq3:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoEsq3			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraEsq3		# Se pedra estiver apoiada, não move
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraEsq3		# Se pedra estiver apoiada, não move
	sb t0, -1(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, -1
	la a4, pedra
	jal s9, spriteNotImm
	addi a3, a3, 2
	jal s11, animacaoChute
	j checaEspinhoEsq3
	
naoMovePedraEsq3:	
	addi a3, a3, 1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoEsq3:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoEsq3
	jal s11, animacaoFuro
	j esquerdaLivre3
deixaEspinhoEsq3:
	addi a3, a3, 1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a3, a3, -1
	bne t2, t0, esquerdaLivre3
	addi a3, a3, 1
	la a4, espinho
	jal s9, spriteNotImm3
	addi a3, a3, -1
esquerdaLivre3:
	la a4, hero
	jal s9, spriteNotImm3
	
	j fase3_loop	 		# Reitera o loop
moveBaixo3:
	#addi s10, s10, -1
	jal calculaPosicaoFase3
	
	la a4, tampao
	jal s9, spriteNotImm3


	addi a6, a6, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)

	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoBaixo3
	addi a6, a6, -1
	j checaEspinhoBaixo3
	
checaEsqueletoBaixo3:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraBaixo3		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoBx3		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueletoBx3
	sb t0, 10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a6, a6, 1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm

	addi a6, a6, -2					# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoBaixo3
MorteDoEsqueletoBx3:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	jal calculaPosicaoFase3				# Desenha o tampão onde estava o esqueleto	
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, -1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoBaixo3
	
checaPedraBaixo3:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoBaixo3			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraBaixo3		# Se pedra estiver apoiada, não move
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraBaixo3		# Se pedra estiver apoiada, não move
	sb t0, 10(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, 1
	la a4, pedra
	jal s9, spriteNotImm
	addi a6, a6, -2
	jal s11, animacaoChute
	j checaEspinhoBaixo3
naoMovePedraBaixo3:	
	addi a6, a6, -1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoBaixo3:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoBaixo3
	jal s11, animacaoFuro
	j BaixoLivre3
deixaEspinhoBaixo3:
	addi a6, a6, -1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a6, a6, 1
	bne t2, t0, BaixoLivre3
	addi a6, a6, -1
	la a4, espinho
	jal s9, spriteNotImm3
	addi a6, a6, 1
BaixoLivre3:
	la a4, hero
	jal s9, spriteNotImm3
	
	j fase3_loop
moveDireita3:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm3

	addi a3, a3, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoDireita3
	addi a3, a3, -1
	j checaEspinhoDir3
	
checaEsqueletoDireita3:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraDir3		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 1(t1)				#Armazena o quadrado a direita do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoDir3		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoDir3		# Se esweuelto estiver encurralado, ele morre
	sb t0, 1(t1)				# Se for esqueleto, muda a memória do quadrado do lado para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a3, a3, 1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm
	addi a3, a3, -2					# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoDir3
MorteDoEsqueletoDir3:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm3
	
	addi a3, a3, -1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoDir3
checaPedraDir3:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoDir3			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, 1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir3		# Se pedra estiver apoiada, não move
	lb t3, 1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir3	 # Se pedra estiver apoiada, não move
	sb t0, 1(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, 1
	la a4, pedra
	jal s9, spriteNotImm
	addi a3, a3, -2
	jal s11, animacaoChute
	j checaEspinhoDir3
	
naoMovePedraDir3:	
	addi a3, a3, -1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoDir3:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoDir3
	jal s11, animacaoFuro
	j DireitaLivre3
deixaEspinhoDir3:
	addi a3, a3, -1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a3, a3, 1
	bne t2, t0, DireitaLivre3
	addi a3, a3, -1
	la a4, espinho
	jal s9, spriteNotImm3
	addi a3, a3, 1
DireitaLivre3:
	la a4, hero
	jal s9, spriteNotImm3
	
	j fase3_loop

fase3_morte:
	la a0, Fase3Morte
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	la a0,Fase3Morte
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	jal readKeyBlocking
	j fase3
fase_3DialogCase:
	beq a6,s6,fase_3AbreDialogo
	j fase_3AfterComparison
fase_3AbreDialogo:
# Sempre começar o diálogo na primeira opção
	li t0, 0xFF200604
	li t1, 0
	sw t1, 0(t0)
	
	la a0, cerberusBackground
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	la a0, f3_b2
	li a1, 4
	li a2, 135
	lw t0, frame_zero
	jal drawImage
	la a0, f3_b1
	li a1, 4
	li a2, 185
	lw t0, frame_zero
	jal drawImage
	
	la a0, cerberusBackground
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	la a0, f3_b3
	li a1, 4
	li a2, 135
	lw t0, frame_one
	jal drawImage
	la a0, f3_b4
	li a1, 4
	li a2, 185
	lw t0, frame_one
	jal drawImage

fase_3UserChoice:
	jal readKeyBlocking				# L? input do usu?rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c?digo ascii da tecla enter em t2
	beq a0,t2,fase3_userChoose				# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,fase_3ChangeChoice				# Se w for selecionado, muda sele??o
	beq a0,t0,fase_3ChangeChoice			# Se s for selecionado, muda sele??o
	j fase_3UserChoice 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
fase_3ChangeChoice:
	jal changeFrame					# Muda tela
fase_3ChoicLoop:
	j fase_3UserChoice				#Reitera o loop

fase3_userChoose:
	bne a5,zero,fase_3RightChoice
	la a0, cerberusFirstWrongAnswern
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero,Justice_firstWrongAnswern,0,0)
	jal changeFrame
	jal readKeyBlocking
	jal clearFrames
	j fase3
fase_3RightChoice:
	la a0, cerberusFirsRightAnswerrn  
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero,Justice_firstRightAnswern,0,0)
	jal readKeyBlocking
#QuartaFASE
fase4:
	jal clearFrames
	#clearFrame(frame_zero)			# Limpa os frames
	#clearFrame(frame_one)
	la a0, mapa4
	li a1, 70
	li a2, 20
	lw t0, frame_zero
	jal drawImage
	la a0, mapa4
	li a1, 70
	li a2, 20
	lw t0, frame_one
	jal drawImage
		

        li a3, 6
	li a6, 1
	jal calculaPosicaoFase3	
	la a0, justice
	lw t0, frame_zero			# Endereco da memoria vga
	mv a1, t1
	mv a2, t2
	jal drawImageNotImm
	li a3, 6
	li a6, 1
	jal calculaPosicaoFase3	
	la a0, justice
	lw t0, frame_one			# Endereco da memoria vga
	mv a1, t1
	mv a2, t2
	jal drawImageNotImm
	
# Salvando a colisão em um novo local da memória para não afetar a original
	li s11, 0		# Primeiro quadrado do mapa
	la a0, colisao_fase_4	# Escolhe o arquivo de colisao da fase
	jal s9, copiaColisao
# Desenhando Pedras no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaPedras
# Desenhando Esqueletos no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaEsqueletos
# Desenhando Espinhos no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaEspinhos
# Desenhando Chave no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaChaves
# Desenhando Baú no Mapa
	li s11, 0	# Primeiro quadrado do mapa
	jal s9, desenhaBaus


# Desenhando o Heroi
plotaHeroi4:
	li a3, 2				# Marca o posicionamento inincial do eixo x do her?i
	li a6, 3 				# Marca o posicionamento inincial do eixo y do her?i
	li s3, 5				# Marca o eixo x do ponto que abre a caixa de dialogo
	li s6, 1			        # Marca o eixo y do ponto que abre a caixa de dialogo
	
	la a4, hero
	jal s9, spriteNotImm3

# Seta Contador de passos
	li s10, 26


fase4_loop:
	beq a3, s3, fase_4DialogCase
	ble s10, zero, fase4_morte
fase_4AfterComparison:
# Mostrando a vida na tela
	mv s9, a3
	mv a0, s10
	li t0, 10 
	
	blt a0, t0, digito_unico4
	
	add t6,a0,zero
	li a7,104
	la a0,movRest
	li a1,2
	li a2,3
	li a3,255
	li a4,0
	ecall
	add a0, t6,zero
	
	li a1, 2
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
	j vida_continua4
digito_unico4:
	li a1, 10
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
	li a0, 0
	li a1, 2
	li a2, 22
	li a3, 255
	li a4, 0
	li a7, 101
	ecall
	lw a4, frame_one
	ecall
vida_continua4:
	mv a3, s9

# Checando teclas pressionadas
	jal readKeyNonBlocking			# l? input do usu?rio	
	li t0, 'w'				# armazena c?digo da letra w em t0
	beq a0, t0 , moveCima4		# Se input for w, roda o comando de mover para cima
	li t0, 'a'
	beq a0, t0, moveEsquerda4
	li t0, 's'
	beq a0, t0, moveBaixo4
	li t0, 'd'
	beq a0, t0, moveDireita4
	j fase4_loop					# Se n?o for, checa o caso do input ser a
moveCima4:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm3
	
	addi a6, a6, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoCima4
	addi a6, a6, 1
	j checaEspinhoCima4
checaEsqueletoCima4:
	addi s10,s10,-1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraCima4		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueleto4		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueleto4
	sb t0, -10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	la a4, tampao
	jal s9, spriteNotImm

	addi a6, a6, -1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm
	
	addi a6, a6, 2						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoCima4
MorteDoEsqueleto4:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm3

	addi a6, a6, 1
	
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3

	j checaEspinhoCima4
checaPedraCima4:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoCima4			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraCima4		# Se pedra estiver apoiada, não move
	lb t3, -10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraCima4		# Se pedra estiver apoiada, não move
	sb t0, -10(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, -1
	la a4, pedra
	jal s9, spriteNotImm
	addi a6, a6, 2
	jal s11, animacaoChute
	j checaEspinhoCima4
naoMovePedraCima4:	
	addi a6, a6, 1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoCima4:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoCima4
	jal s11, animacaoFuro
	j cimaLivre4
deixaEspinhoCima4:
	addi a6, a6, 1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a6, a6, -1
	bne t2, t0, cimaLivre4
	addi a6, a6, 1
	
	la a4, espinho
	jal s9, spriteNotImm3
	addi a6, a6, -1
cimaLivre4:
	la a4, hero
	jal s9, spriteNotImm3
	j fase4_loop
moveEsquerda4:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm3
	
	addi a3, a3, -1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoEsq4
	addi a3, a3, 1
	j checaEspinhoEsq4
checaEsqueletoEsq4:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraEsq4    # Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoEsq4		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueletoEsq4
	sb t0, -1(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a3, a3, -1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm	
	addi a3, a3, 2						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoEsq4
	
MorteDoEsqueletoEsq4:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, 1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoEsq4
checaPedraEsq4:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoEsq4			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraEsq4		# Se pedra estiver apoiada, não move
	lb t3, -1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraEsq4		# Se pedra estiver apoiada, não move
	sb t0, -1(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio

	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, -1
	la a4, pedra
	jal s9, spriteNotImm
	addi a3, a3, 2
	jal s11, animacaoChute
	j checaEspinhoEsq4
	
naoMovePedraEsq4:	
	addi a3, a3, 1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoEsq4:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoEsq4
	jal s11, animacaoFuro
	j esquerdaLivre4
deixaEspinhoEsq4:
	addi a3, a3, 1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a3, a3, -1
	bne t2, t0, esquerdaLivre4
	addi a3, a3, 1
	la a4, espinho
	jal s9, spriteNotImm3
	addi a3, a3, -1
esquerdaLivre4:
	la a4, hero
	jal s9, spriteNotImm3
	
	j fase4_loop	 		# Reitera o loop
moveBaixo4:
	#addi s10, s10, -1
	jal calculaPosicaoFase3
	
	la a4, tampao
	jal s9, spriteNotImm3


	addi a6, a6, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)

	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoBaixo4
	addi a6, a6, -1
	j checaEspinhoBaixo4
	
checaEsqueletoBaixo4:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraBaixo4		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoBx4		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'
	beq t3, t4, MorteDoEsqueletoBx4
	sb t0, 10(t1)				# Se for esqueleto, muda a memória do quadrado acima para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a6, a6, 1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm

	addi a6, a6, -2					# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoBaixo4
MorteDoEsqueletoBx4:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	jal calculaPosicaoFase3				# Desenha o tampão onde estava o esqueleto	
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, -1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoBaixo4
	
checaPedraBaixo4:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoBaixo4			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraBaixo4		# Se pedra estiver apoiada, não move
	lb t3, 10(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraBaixo4		# Se pedra estiver apoiada, não move
	sb t0, 10(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a6, a6, 1
	la a4, pedra
	jal s9, spriteNotImm
	addi a6, a6, -2
	jal s11, animacaoChute
	j checaEspinhoBaixo4
naoMovePedraBaixo4:	
	addi a6, a6, -1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoBaixo4:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoBaixo4
	jal s11, animacaoFuro
	j BaixoLivre4
deixaEspinhoBaixo4:
	addi a6, a6, -1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a6, a6, 1
	bne t2, t0, BaixoLivre4
	addi a6, a6, -1
	la a4, espinho
	jal s9, spriteNotImm3
	addi a6, a6, 1
BaixoLivre4:
	la a4, hero
	jal s9, spriteNotImm3
	
	j fase4_loop
moveDireita4:
	#addi s10, s10, -1
	la a4, tampao
	jal s9, spriteNotImm3

	addi a3, a3, 1		# atualiza t2 para pr?xima posi??o do personagem (que s? se movimenta no eixo y)
	li t0, 'X'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, checaEsqueletoDireita4
	addi a3, a3, -1
	j checaEspinhoDir4
	
checaEsqueletoDireita4:
	addi s10, s10, -1
	li t0, 'E'				# E representa esqueleto no mapa
	bne t2, t0, checaPedraDir4		# Checa se tem esqueleto, se não segue normalmente
	#Se tiver esqueleto e quadrado acima do esqueleto for "x", O Esqueleto morre
	lb t3, 1(t1)				#Armazena o quadrado a direita do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoDir4		# Se esweuelto estiver encurralado, ele morre
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, MorteDoEsqueletoDir4		# Se esweuelto estiver encurralado, ele morre
	sb t0, 1(t1)				# Se for esqueleto, muda a memória do quadrado do lado para E
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm

	addi a3, a3, 1						# Sobe uma posição na matriz
	la a4, esqueleto
	jal s9, spriteNotImm
	addi a3, a3, -2					# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
	j checaEspinhoDir4
MorteDoEsqueletoDir4:
	sb zero, (t1)				# Se for pra morrer, muda a memória do quadrado do esqueleto pra 0
	la a4, tampao
	jal s9, spriteNotImm3
	
	addi a3, a3, -1
	jal s11, animacaoChute
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2000		# define a duração da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	j checaEspinhoDir4
checaPedraDir4:
	li t0, 'P'				# P representa pedra no mapa
	bne t2, t0, checaEspinhoDir4			# Checa se tem esqueleto, se não segue normalmente
	#Se tiver pedra e quadrado acima da pedra for "X" ou "P", a pedra não move
	lb t3, 1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'X'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir4		# Se pedra estiver apoiada, não move
	lb t3, 1(t1)				#Armazena o quadrado acima do esqueleto
	li t4, 'P'				#Armazena  "x" em t4
	beq t3,t4, naoMovePedraDir4  # Se pedra estiver apoiada, não move
	sb t0, 1(t1)				# Se for pedra, muda a memória do quadrado acima para P
	li t0, '0'				# Carrega 0 que representa espaço vazio
	sb t0, 0(t1)				# Muda a memória no quadrado para espaço vazio
	
	la a4, tampao
	jal s9, spriteNotImm
	
	addi a3, a3, 1
	la a4, pedra
	jal s9, spriteNotImm
	addi a3, a3, -2
	jal s11, animacaoChute
	j checaEspinhoDir4
	
naoMovePedraDir4:	
	addi a3, a3, -1						# Corrige a posição de volta para o personagem
	jal s11, animacaoChute
checaEspinhoDir4:
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	bne t2, t0, deixaEspinhoDir4
	jal s11, animacaoFuro
	j DireitaLivre4
deixaEspinhoDir4:
	addi a3, a3, -1
	li t0, 'T'
	la t1, colisao_temporaria
	li t2, 10
	mul t2, a6, t2
	add t2, t2, a3
	add t1, t1, t2
	lb t2, 0(t1)
	addi a3, a3, 1
	bne t2, t0, DireitaLivre4
	addi a3, a3, -1
	la a4, espinho
	jal s9, spriteNotImm3
	addi a3, a3, 1
DireitaLivre4:
	la a4, hero
	jal s9, spriteNotImm3
	
	j fase4_loop

fase4_morte:
	la a0, Fase4Morte
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	la a0,Fase4Morte
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	jal readKeyBlocking
	j fase4
fase_4DialogCase:
	beq a6,s6,fase_4AbreDialogo
	j fase_4AfterComparison
fase_4AbreDialogo:
# Sempre começar o diálogo na primeira opção
	li t0, 0xFF200604
	li t1, 0
	sw t1, 0(t0)
	
	la a0, zdradaBackground1
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	la a0, f4_b2
	li a1, 4
	li a2, 135
	lw t0, frame_zero
	jal drawImage
	la a0, f4_b4
	li a1, 4
	li a2, 185
	lw t0, frame_zero
	jal drawImage
	
	la a0, zdradaBackground1
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	la a0, f4_b1
	li a1, 4
	li a2, 135
	lw t0, frame_one
	jal drawImage
	la a0, f4_b3
	li a1, 4
	li a2, 185
	lw t0, frame_one
	jal drawImage

fase_4UserChoice:
	jal readKeyBlocking				# L? input do usu?rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c?digo ascii da tecla enter em t2
	beq a0,t2,fase4_userChoose				# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,fase_4ChangeChoice				# Se w for selecionado, muda sele??o
	beq a0,t0,fase_4ChangeChoice			# Se s for selecionado, muda sele??o
	j fase_4UserChoice 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
fase_4ChangeChoice:
	jal changeFrame					# Muda tela
fase_4ChoicLoop:
	j fase_4UserChoice				#Reitera o loop

fase4_userChoose:
	bne a5,zero,fase_4RightChoice
	la a0, ZdradaFirstWrongAnswern
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero,Justice_firstWrongAnswern,0,0)
	jal changeFrame
	jal readKeyBlocking
	jal clearFrames
	j fase4
fase_4RightChoice:
	la a0, zdradaBackground2
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	
	la a0, f4_b5
	li a1, 4
	li a2, 135
	lw t0, frame_one
	jal drawImage
	la a0, f4_b7
	li a1, 4
	li a2, 185
	lw t0, frame_one
	jal drawImage
	
	la a0, zdradaBackground2
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	la a0, f4_b6
	li a1, 4
	li a2, 135
	lw t0, frame_zero
	jal drawImage
	la a0, f4_b8
	li a1, 4
	li a2, 185
	lw t0, frame_zero
	jal drawImage
fase_4UserChoice2:
	jal readKeyBlocking				# L? input do usu?rio para navegar no menu
	li t0,'w'					# Armazena carcter 'w' em t0
	li t1,'s'					# Armazena caracter 's' em t1
	li t2, 10					# Armazena c?digo ascii da tecla enter em t2
	beq a0,t2,fase4_userChoose2				# Se "enter for selecionado, salta o loop do menu
	beq a0,t1,fase_4ChangeChoice2				# Se w for selecionado, muda sele??o
	beq a0,t0,fase_4ChangeChoice2			# Se s for selecionado, muda sele??o
	j fase_4UserChoice2 					# Se nem w, nem s, nem enter forem selecionadas, refaz o loop
fase_4ChangeChoice2:
	jal changeFrame					# Muda tela
fase_4ChoicLoop2:
	j fase_4UserChoice2				#Reitera o loop

fase4_userChoose2:
	bne a5,zero,fase_4RightChoice2
	la a0, ZdradaSecondWrongAnswern
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage
	#drawImage(frame_zero,Justice_firstWrongAnswern,0,0)
	jal changeFrame
	jal readKeyBlocking
	jal clearFrames
	j fase4
fase_4RightChoice2:
	la a0, ZdradaSecondRightAnswern
	li a1, 0
	li a2, 0
	lw t0, frame_one
	jal drawImage

	la a0, ZdradaSecondRightAnswern
	li a1, 0
	li a2, 0
	lw t0, frame_zero
	jal drawImage
	
	jal readKeyBlocking
	
## Quinta Fase
#fase5:
	li a0,2000		# pausa de 2 segundos
	li a7,32		
	ecall
	
	jal clearFrames
	#clearFrame(frame_zero)	# apaga os frames
	#clearFrame(frame_one)
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
	
 calculaPosicaoFase3:
 	li t1,70
	li t2, 20
	mul t2, t2, a3 
	add t1, t1, t2   # t1 armazena a coordenada x
	li t2, 20
	addi t5, a6,1
	mul t2, t2,t5	#t2 armazena a coordenada y 
	ret
	
#desenhaHeroiFrameEscondido:
#	xori t4,a5,1                               
#	beq t4,zero,HeroiFrameZeroEscondido
#	j HeroiFrameOneEscondido
#HeroiFrameZeroEscondido:
#	#drawImageNotImm(frame_zero,hero,t1,t2)
#	ret
#HeroiFrameOneEscondido:
#	drawImageNotImm(frame_one,hero,t1,t2)
#	ret

#desenhaTampaoFrameEscondido:
#	xori t4,a5,1
#	beq t4,zero,TampaoFrameZeroEscondido
#	j TampaoFrameOneEscondido
#TampaoFrameZeroEscondido:
#	drawImageNotImm(frame_zero,tampao,t1,t2)
#	ret
#TampaoFrameOneEscondido:
#	drawImageNotImm(frame_one,tampao,t1,t2)
#	ret
drawImage:
# Desenha uma figura de qualquer tamanho na tela de bitmap
	#
	# a0: imagem
	# a1: coordenada x
	# a2: coordenada y
		#la a0, %imagem
		#lw t0, %frame			# Endereco da memoria vga
		#li a1, %coord_x
		#li a2, %coord_y
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
	beqz t1, gridOk2			# Se n?o for divis?vel por 4 dara problema de desalinhamento de endere?amento da mem?ria
	sub t0, t0, t1			# Nesse caso, escolhe o endere?o v?lido imediatamente ? esquerda
gridOk2:
	add t1, zero, a0		# Endere?o da imagem
	lw t2, 0(t1)			# Largura da imagem
	lw t3, 4(t1)			# Altura da imagem
	addi t1, t1, 8			# Muda t1 para o primeiro pixel da imagem, ap?s informa??es de altura e largura
	li t4, 0			# Iterador de colunas
	li t5, 0			# Iterador de linhas
drawLoop2:	
	beq t5, t3, endDraw2		# Verifica se desenhou todas as linhas da imagem
	blt t4, t2, continueLine2	# Se n?o chegou ao final da linha continua desenhando
	sub t0, t0, t4		# Reinicia o endere?o vga para o primeiro pixel da linha
	li t4, 0		# Reinicia o iterador de coluna
	addi t5, t5, 1		# Incrementa iterador de linha
	addi t0, t0, 320	# Pr?xima linha na mem?ria vga
	j drawLoop2
continueLine2:
	lw t6, 0(t1)			# Carrega pixel da imagem
	li s0, 0xFF00FF			# Cor Magente (Transparente)
	beq t6, s0, transparent2		# N?o desenha o pixel transparente
	sw t6, 0(t0)			# Escreve pixel na mem?ria vga
transparent2:
	addi t0, t0, 4			# Pr?ximo endere?o da mem?ria vga
	addi t1, t1, 4			# Pr?ximo pixel da imagem
	addi t4, t4, 4			# Incrementa iterador			
	j drawLoop2
endDraw2:
	li a0, 0			# Limpa o registro pra retornar
	li a1, 0			# Limpa o registro pra retornar
	li a2, 0			# Limpa o registro pra retornar
	ret

clearFrames:
	li t0, 76800
	lw t1, frame_zero	# endereco inicial da Memoria VGA - Frame 0
	add t2, t0, t1		# endereco final 
	li t3,0x00000000	# cor vermelho|vermelho|vermelhor|vermelho
cf_loop1: 	
	beq t1,t2,cf_fora1	# Se for o ?ltimo endere?o ent?o sai do loop
	sw t3,0(t1)		# escreve a word na mem?ria VGA
	addi t1,t1,4		# soma 4 ao endere?o
	j cf_loop1
cf_fora1:
	li t0, 76800
	lw t1, frame_one	# endereco inicial da Memoria VGA - Frame 0
	add t2, t0, t1		# endereco final 
	li t3,0x00000000	# cor vermelho|vermelho|vermelhor|vermelho
cf_loop2: 	
	beq t1,t2,cf_fora2	# Se for o ?ltimo endere?o ent?o sai do loop
	sw t3,0(t1)		# escreve a word na mem?ria VGA
	addi t1,t1,4		# soma 4 ao endere?o
	j cf_loop2
cf_fora2:
	ret


# Animação do Chute
animacaoChute:
	jal calculaPosicaoFase2	
	la a0, hero_kick
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, hero_kick
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	li a0, 300		# pausa de 1/10 segundos
	li a7, 32		
	ecall
	# Toca o som do chute
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,45		# define a nota
	li a1,2500		# define a duração da nota em ms
	li a2,118		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	jal calculaPosicaoFase2	
	la a0, tampao
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, tampao
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jr s11

# Animação do Furo
animacaoFuro:
	addi s10, s10, -1
	jal calculaPosicaoFase2	
	la a0, espinho
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, espinho
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	jal calculaPosicaoFase2	
	la a0, hero_hurt
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, hero_hurt
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	li a0, 300		# pausa de 1/10 segundos
	li a7, 32		
	ecall
	
	# Toca o som esqueleto morrendo
	mv s0, a3		# salva o valor de a3, porque será usado pra volume
	li a0,75		# define a nota
	li a1,1000		# define a duração da nota em ms
	li a2,65		# define o instrumento
	li a3,127		# define o volume
	li a7,31		# define o syscall
	ecall			# toca a nota
	mv a3, s0		# recupera o valor de a3
	
	jal calculaPosicaoFase2	
	la a0, tampao
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, tampao
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	
	jal calculaPosicaoFase2	
	la a0, espinho
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2
	la a0, espinho
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jr s11

copiaColisao:
	li t1, 89	# Último quadrado do mapa
	bgt s11, t1, continuaColisao

	la t2, colisao_temporaria
	mv t3, a0
	add t2, t2, s11
	add t3, t3, s11
	lb t4, 0(t3)
	sb t4, 0(t2)
	addi s11, s11, 1
	j copiaColisao
continuaColisao:
	jr s9
	
desenhaPedras:
	li t1, 89	# Último quadrado do mapa
	bgt s11, t1, desenhaPedrasContinua

	li t2, 'P'
	la t3, colisao_temporaria
	add t3, t3, s11
	lb t4, 0(t3)
	bne t4, t2, naoDesenhaPedra
		li t3, 10
		rem a3, s11, t3
		div a6, s11, t3
		jal calculaPosicaoFase2	
		la a0, pedra
		lw t0, frame_zero			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
		jal calculaPosicaoFase2	
		la a0, pedra
		lw t0, frame_one			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
naoDesenhaPedra:	
	addi s11, s11, 1
	j desenhaPedras
desenhaPedrasContinua:
	jr s9

desenhaEsqueletos:
	li t1, 89	# Último quadrado do mapa
	bgt s11, t1, desenhaEsqueletosContinua

	li t2, 'E'
	la t3, colisao_temporaria
	add t3, t3, s11
	lb t4, 0(t3)
	bne t4, t2, naoDesenhaEsqueleto
		li t3, 10
		rem a3, s11, t3
		div a6, s11, t3
		jal calculaPosicaoFase2	
		la a0, esqueleto
		lw t0, frame_zero			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
		jal calculaPosicaoFase2	
		la a0, esqueleto
		lw t0, frame_one			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
naoDesenhaEsqueleto:	
	addi s11, s11, 1
	j desenhaEsqueletos
desenhaEsqueletosContinua:
	jr s9

desenhaEspinhos:
	li t1, 89	# Último quadrado do mapa
	bgt s11, t1, desenhaEspinhosContinua

	li t2, 'T'
	la t3, colisao_temporaria
	add t3, t3, s11
	lb t4, 0(t3)
	bne t4, t2, naoDesenhaEspinho
		li t3, 10
		rem a3, s11, t3
		div a6, s11, t3
		jal calculaPosicaoFase2	
		la a0, espinho
		lw t0, frame_zero			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
		jal calculaPosicaoFase2	
		la a0, espinho
		lw t0, frame_one			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
naoDesenhaEspinho:	
	addi s11, s11, 1
	j desenhaEspinhos
desenhaEspinhosContinua:
	jr s9

desenhaChaves:
	li t1, 89	# Último quadrado do mapa
	bgt s11, t1, desenhaEspinhosContinua

	li t2, 'K'
	la t3, colisao_temporaria
	add t3, t3, s11
	lb t4, 0(t3)
	bne t4, t2, naoDesenhaChaves
		li t3, 10
		rem a3, s11, t3
		div a6, s11, t3
		jal calculaPosicaoFase2	
		la a0, chave
		lw t0, frame_zero			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
		jal calculaPosicaoFase2	
		la a0, chave
		lw t0, frame_one			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
naoDesenhaChaves:
	addi s11,s11, 1
	j desenhaChaves
desenhaChavesContinua:
	jr s9

desenhaBaus:
	li t1, 89	# Último quadrado do mapa
	bgt s11, t1, desenhaBausContinua

	li t2, 'B'
	la t3, colisao_temporaria
	add t3, t3, s11
	lb t4, 0(t3)
	bne t4, t2, naoDesenhaBau
		li t3, 10
		rem a3, s11, t3
		div a6, s11, t3
		jal calculaPosicaoFase2	
		la a0, bau
		lw t0, frame_zero			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
		jal calculaPosicaoFase2	
		la a0, bau
		lw t0, frame_one			# Endereco da memoria vga
		add a1,zero,t1
		add a2,zero, t2
		jal drawImageNotImm
naoDesenhaBau:	
	addi s11, s11, 1
	j desenhaBaus
desenhaBausContinua:
	jr s9


spriteNotImm:
	jal calculaPosicaoFase2	
	mv a0, a4
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase2	
	mv a0, a4
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jr s9
spriteNotImm3:
	jal calculaPosicaoFase3	
	mv a0, a4
	lw t0, frame_zero			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jal calculaPosicaoFase3	
	mv a0, a4
	lw t0, frame_one			# Endereco da memoria vga
	add a1,zero,t1
	add a2,zero, t2
	jal drawImageNotImm
	jr s9
# Tem que ser a última coisa!
.include "SYSTEMv21.s"
