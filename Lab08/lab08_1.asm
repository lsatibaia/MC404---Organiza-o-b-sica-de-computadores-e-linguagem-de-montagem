.section .data
	#frase que ira ser impressa pedindo os 5 numeros de entrada
	frase_de_entrada:
		.word 0x69676944
		.word 0x35206574
		.word 0x6d756e20
		.word 0x736f7265
		.word 0x0000203a

	#frase que sera impressa antes do vetor ordenado
	frase_ordenada:
		.word 0x75676553
		.word 0x206f2065
		.word 0x6f746576
		.word 0x726f2072	
		.word 0x616e6564
		.word 0x203a6f64

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

	#faz s0 apontar para o endereco do primeiro espaco do vetor
	lui s0, %hi(vetor)
	addi s0, s0, %lo(vetor)
	addi t1, zero, 5
	
	#guarda o endereco do inicio do vetor
	add t2, zero, s0

	#chama todas as funcoes que serao usadas
	call ler
	call ordenar
	call imprimir

	#puxa o endereco que o programa deve voltar e o faz o retorno
	lw ra, 0(sp)
	addi sp, sp, 4

	ret



#funcao que faz a leitura dos 5 numeros
	ler:
		#imprime a frase que da o comando para que seja realizada a insercao dos 5 numeros
		lui a0, %hi(frase_de_entrada)
		addi a0, a0, %lo(frase_de_entrada)
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




	#funcao que ordena os valores do vetor
	#a funcao usa a logica bubble sort para ordenar
	#o return1 fara com que o programa percorra o vetor do inicio ao fim
	#o return2 fara com que ele faca o mesmo procedimento 4 vezes, para que o vetor fique ordenado ate quando o maior numero vem por ultimo
	#quando ele encontra um numero menor que esta mais pro final do vetor, realiza-se a troca desse numero com o seu anterior
	ordenar:
		addi t3, zero, 4
return2:
		addi t4, zero, 4
		add s0, zero, t2
return1:
		lw t5, 0(s0) 
		addi s0, s0, 4
		lw t6, 0(s0)
		blt t5, t6, fim
		addi s0, s0, -4
		sw t6, 0(s0)
		addi s0, s0, 4
		sw t5, 0(s0)

fim:
		addi t4, t4, -1
		bne t4, zero, return1
		addi t3, t3, -1
		bne t3, zero, return2
	ret




	#imprime a frase e em seguida o vetor ordenado
	imprimir:
		lui a0, %hi(frase_ordenada)
		addi a0, a0, %lo(frase_ordenada)
		addi t0, zero, 3
		addi a1, zero, 24
		ecall
		addi t3, zero, 5
		add s0, zero, t2
return3:
		lw t4, 0(s0)
		addi s0, s0, 4
		add a0, zero, t4
		addi t0, zero, 1
		ecall
		addi t3, t3, -1
		bne t3, zero, return3

	ret

