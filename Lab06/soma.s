#lab06 - Programa calcula a soma de dois numeros e imprime


.section .text

main:

#Faz a leitura de um input (quando t0 = 4 e damos o ecall, o programa faz a leiura de um inteiro) e armazena em a0
	addi t0,zero,4
	ecall

#Adiciona o valor de a0 em t1
	add t1,a0,zero
	
#Faz a mesma operacao para adicionar um input em a0
	addi t0,zero,4
	ecall

#Adiciona o valor de a0 em t2
	add t2,a0,zero

#Realiza a soma t1 e t2 e guarda o resultado em a0
	add a0,t1,t2  

#Imprime o inteiro - t0=1 e a0 o inteiro
	addi t0,zero,1  
	ecall  

	jr ra