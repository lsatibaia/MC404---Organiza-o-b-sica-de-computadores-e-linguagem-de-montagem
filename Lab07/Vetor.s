.section .data
	#quando imprimir, imprime a frase: Digite 5 numeros
	frase_entrada:
		.word 0x69676944
		.word 0x35206574
		.word 0x6d756e20
		.word 0x736f7265
		.word 0x0000203a

	#quando imprimir, imprime a frase: Soma:
	frase_soma:
		.word 0x616d6f53
		.word 0x0000203a

	#quando imprimir, imprime a frase: Maior:
	frase_maior:
		.word 0x6f69614d
		.word 0x00203a72

	#quando imprimir, imprime a frase: Menor:
	frase_menor:
		.word 0x6f6e654d
		.word 0x00203a72

	#vetor que tem 5 espacos para os 5 numeros que serao colocados
	vetor:
		.word 0
		.word 0
		.word 0
		.word 0
		.word 0


.section .text
main: 

	#armazena em sp o endereco que o programa deve voltar depois de todas as operacoes
	addi sp, sp, -4
	sw ra, 0(sp)

	#aponta para o endereco do primeiro espaco do vetor
	lui s0, %hi(vetor)
	addi s0, s0, %lo(vetor)
	addi t1, zero, 5
	
	#guarda o endereco do inicio do vetor
	add t2, zero, s0

	#chama todas as funcoes que serao usadas
	call ler
	call maior
	call menor
	call soma
	call imprimir

	#puxa o endereco que o programa deve voltar e o faz
	lw ra, 0(sp)
	addi sp, sp, 4

	ret



#funcao que faz a leitura dos 5 numeros
	ler:
		#imprime a frase que da o comando para que seja realizada a insercao dos 5 numeros
		lui a0, %hi(frase_entrada)
		addi a0, a0, %lo(frase_entrada)
		addi t0, zero, 3
		addi a1, zero, 18
		ecall


		addi t0, zero, 4
return:
		ecall
		#vai colocando os numeros nos espacos do vetor ao passo que o endeereco vai adicionando 4 em 4 bytes
		sw a0, 0(s0)

		addi s0, s0, 4
		addi t1, t1, -1
		bne t1, zero, return

	ret




	#funcao que ira rodar todo o vetor e guarda em t3 o valor maior
	maior:
		addi t1, zero, 5
		add s0, zero, t2
		addi s0, s0, -4
return1:
		addi s0, s0, 4
		lw t6, 0(s0)
		blt t6, t3, fim
		add t3, zero, t6
fim:
		addi t1, t1, -1
		bne t1, zero, return1

	ret	




	#funcao que ira rodar todo o vetor, praticamenre igual a funcao de maior, e guarda em t4 o menor valor
	menor:
		addi t1, zero, 4
		add s0, zero, t2
		lw t6, 0(s0)
		add t4, zero, t6
return2:
		addi s0, s0, 4
		lw t6, 0(s0)
		blt t4, t6, fim1
		add t4, zero, t6
fim1:
		addi t1, t1, -1
		bne t1, zero, return2

	ret	




	#roda todo o vetor e soma os numeros que estao nele
	soma:
		addi t1, zero, 4
		add s0, zero, t2
		lw t6, 0(s0)
		add t5, t5, t6
return3:
		addi s0, s0, 4
		lw t6, 0(s0)
		add t5, t5, t6
		addi t1, t1, -1
		bne t1, zero, return3
		
	ret




	#imprime os resultados obtidos logo apos a frase que representa o valor obtido
	imprimir:
		lui a0, %hi(frase_maior)
		addi a0, a0, %lo(frase_maior)
		addi t0, zero, 3
		addi a1, zero, 7
		ecall
		add a0, zero, t3
		addi t0, zero, 1
		ecall
		
		
		lui a0, %hi(frase_menor)
		addi a0, a0, %lo(frase_menor)
		addi t0, zero, 3
		addi a1, zero, 7
		ecall
		add a0, zero, t4
		addi t0, zero, 1
		ecall


		lui a0, %hi(frase_soma)
		addi a0, a0, %lo(frase_soma)
		addi t0, zero, 3
		addi a1, zero, 6
		ecall
		add a0, zero, t5
		addi t0, zero, 1
		ecall




	ret

