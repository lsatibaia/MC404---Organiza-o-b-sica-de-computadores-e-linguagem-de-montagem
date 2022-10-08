.section .data
	#frase de entrada que sera impressa pedindo para o usuario digitar quantos caracteres (n) quer colocar na pilha
	frase_ent:
		.word 0x69676944
		.word 0x71206574
		.word 0x746e6175
		.word 0x6320736f
		.word 0x63617261
		.word 0x65726574
		.word 0x65642073
		.word 0x616a6573
		.word 0x736e6920
		.word 0x72697265
		.word 0x0000203a 

	#frase que pedira para o usuario inserir os n caracteres
	frase_input:
		.word 0x72637345
		.word 0x20617665
		.word 0x6320736f
		.word 0x63617261
		.word 0x65726574
		.word 0x00203a73

	#frase que sera impressa antes dos caracteres serem impressos na ordem invertida
	frase_sai:
		.word 0x6320734f
		.word 0x63617261
		.word 0x65726574
		.word 0x616e2073
		.word 0x64726f20
		.word 0x69206d65
		.word 0x7265766e
		.word 0x61646974
		.word 0x63696620
		.word 0x203a6d61



.section .text
main:
	#armazena o valor de ra no primeiro espaco da pilha
	addi sp, sp, -4
	sw ra, 0(sp)

	#imprime a frase de entrada
	lui a0, %hi(frase_ent)
	addi a0, a0, %lo(frase_ent)
	addi t0, zero, 3
	addi a1, zero, 41
	ecall

	addi t0, zero, 4
	ecall

	#adiciona o valor de n em t1 e t2, a fim de que possa fazer o sp descer ou subir n vezes -4 ou 4, respect
	add t1, zero, a0
	add t2, zero, t1

	call formar_pilha
	call desempilhar

	lw ra, 0(sp)
	addi sp, sp, 4

	ret




#le os n caracteres que serao inseridos e os coloca na pilha na ordem inserida
formar_pilha:
	lui a0, %hi(frase_input)
	addi a0, a0, %lo(frase_input)
	addi t0, zero, 3
	addi a1, zero, 23
	ecall

	addi t0, zero, 5
	addi sp, sp, -4 
return:
	ecall
	sw a0, 0(sp)
	addi sp, sp, -4
	addi t1, t1, -1
	bne t1, zero, return
	
	#como t1 ficou igual a zero, igualo ele a t2 para voltar a ter o mesmo valor, que e n
	add t1, zero, t2
	#sp foi -4 a mais do que o necessario, logo deve voltar a casa anterior
	addi sp, sp, 4
	
	ret




#desmonta a pilha, imprimindo os caracteres na ordem inversa da ordem que foi inserida
desempilhar:
	lui a0, %hi(frase_sai)
	addi a0, a0, %lo(frase_sai)
	addi t0, zero, 3
	addi a1, zero, 40
	ecall

	#imprime a pilha casa por casa, voltando ao comeco da pilha
	addi t0, zero, 2
return1:
	lw a0, 0(sp)
	ecall 
	addi sp, sp, 4
	addi t1, t1, -1
	bne t1, zero, return1

	ret
	
