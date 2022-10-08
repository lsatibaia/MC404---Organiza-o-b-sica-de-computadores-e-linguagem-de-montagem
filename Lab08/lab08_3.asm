.section .data
	#frase que pedira o numero n que sera calculado o fatorial
	n:
		.word 0x69676944
		.word 0x6f206574
		.word 0x6d756e20
		.word 0x206f7265
		.word 0x20657571
		.word 0x72657571
		.word 0x6c616320
		.word 0x616c7563
		.word 0x206f2072
		.word 0x6f746166
		.word 0x6c616972
		.word 0x0000203a

	#frase que sera impressa antes de imprimir o fatorial em si
	frase_saida:
		.word 0x6166204f
		.word 0x69726f74
		.word 0x203a6c61



.section .text
main:
	addi sp, sp, -4
	sw ra, 0(sp)

	call ler
	call fatorial
	addi sp, sp, 4
	call imprimir

	lw ra, 0(sp)
	addi sp, sp, 4

	ret



#le o numero que sera calculado o fatorial, armazena em t1 e cria a pilha de 1 ate t1 
ler:
	lui a0, %hi(n)
	addi a0 ,a0, %lo(n)
	addi t0, zero, 3
	addi a1, zero, 46
	ecall

	addi t0, zero, 4
	ecall
	#guarda o numero inserido em t1 e t6, que serao usados mais pra frente
	add t1, zero, a0
	add t6, zero, a0

	addi t1, t1, 1

	addi t2, zero, 0
	blt t1, t2, continue

	#cria a pilha de inteiros, comecando por 0 e indo ate n, ja que a multiplicacao vai ser por soma, nao dara problema
	#se n for 1, ainda sim cria e se gera um erro, esse erro foi corrigido na funcao de fatorial
	addi sp, sp, -4
criar:
	sw t2, 0(sp)
	addi sp, sp, -4
	addi t2, t2, 1
	bne t2, t1, criar

	addi sp, sp, 4
	addi t1, t1, -1
	
	addi t3, zero, 1
	add t4, zero, t1

	addi t2, zero, 2
	blt t1, t2, continue
	addi sp, sp, 4	
	lw t1 ,0(sp)
	
continue:
	add t2, zero, t1
	add t5, zero, t1

	ret

	

	#funcao que ira farzer o fatorial do numero inserido
	#funcao que chama a propria funcao para achar o fatorial
fatorial:
	lw t1, 0(sp)
	addi s1, zero, 2
	#faz com que saia da funcao caso n seja igual a 1 ou 0
	blt t6, s1, pular
	#faz um while dentro da funcao, fazendo fazendo a multiplicacao por soma dos numeros e chando o resultado desejado
return:
	add t2, t2, t5
	addi t1, t1, -1
	bne t1, zero, return
	addi sp, sp, 4
	addi t3, t3, 1
	add t5, zero, t2
	addi t2, zero, 0
	bne t3, t4, fatorial

	#se for igual a 0, nao adiciona 4 a sp, uma vez que foi acrescentado em criar e nao foi tirado depois 
	addi sp, sp, -4
pular:
	addi t2, zero, 1
	blt t4, t2, pular1
	addi sp, sp, 4
	addi t2, t2, 0
pular1:
	
	ret


#imprime a frase que indica que e o fatorial e o fatorial em si
imprimir:
	lui a0, %hi(frase_saida)
	addi a0 ,a0, %lo(frase_saida)
	addi t0, zero, 3
	addi a1, zero, 12
	ecall

	#adiciona em a0 o valor resultado da funcao anterior, que no caso, e o vatorial do numero inserido
	add a0, zero, t5
	addi t0, zero, 1
	ecall

	ret






