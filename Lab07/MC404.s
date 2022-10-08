.section .data

	#vai armazenar a string "MC404!" em duas words de 8 bits cada
	#cada word pode armazenar 8 bits
	#cada letra ou simbolo ira usar 2 bits, por isso a necessidade de dois .word
	string:
		.word 0x3034434d
		.word 0x00002134
		

.section .text
main:

	#essa linha ira pegar os 20 bits mais significativos de label e ira colocar em a0
	lui a0, %hi(string)
	addi a0, a0, %lo(string)

	#adiciona 3 a t0 para saber que o comando e imprimir
	addi t0, zero, 3
	#adiciona em a1 o tamanho da string que sera impressa
	addi a1, zero, 6
	ecall 

	jr ra