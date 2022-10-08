#lab06 - multiplicacao de dois numeros por soma

.section .text

main:

#Faz a leitura de dois numeros (t1 e t2) que serao multiplicados por soma
	addi t0,zero,4
	ecall
	add t1,a0,zero
	
	addi t0,zero,4
	ecall
	add t2,a0,zero


#Essa parte do codigo faz um loop que termina quando t1 for igual a 0
#adiciona t2 em t3, faz essa soma t1 vezes
#como se fosse a funcao while (essa e a funcao do bne - enquanto t1 != zero, manda para multiplicacao)
	multiplicacao:
		add t3,t2,t3
		addi t1,t1,-1
		bne t1,zero,multiplicacao


#Iguala t0 a 1 para que quando der um ecall imprima a0
#Adiciona o valor final de t3 em a0 para ser impresso
	addi t0,zero,1
	add a0,zero,t3
	ecall

	jr ra
		