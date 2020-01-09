;Block Transfer Overlapped with String Instruction

section .data
	msg0 db 10, "Assignment No. 2D", 10, "---------------------------------------------", 10, "Block Transfer Overlapped with String Instruction", 10
	msg0_len equ $-msg0
	msg1 db 10, "Before Transfer"
	msg1_len equ $-msg1
	msg2 db 10, "After Tranfer"
	msg2_len equ $-msg2
	msg3 db 10, "Source Block: "
	msg3_len equ $-msg3
	msg4 db 10, "Destination Block: "
	msg4_len equ $-msg4
	br db 10, 10
	br_len equ $-br
	space db " "
	sblock db 10h, 11h, 12h, 13h, 14h, 15h, 16h, 17h, 18h, 19h
	dblock times 4 db 0
	
section .bss
	char_ans resb 2

%MACRO PRINT 2
	MOV rax, 1
	MOV rdi, 1
	MOV rsi, %1
	MOV rdx, %2
	SYSCALL
%ENDMACRO

%MACRO EXIT 0
	MOV rax, 60
	MOV rdi, 0
	SYSCALL
%ENDMACRO
	
section .text
	 global _start
	 _start:
	 	PRINT msg0, msg0_len
	 	
	 	PRINT msg1, msg1_len
		PRINT msg3, msg3_len
		MOV rsi, sblock
		CALL display_block
		
		PRINT msg4, msg4_len
		MOV rsi, dblock-6
		CALL display_block
		
		PRINT br, br_len
		CALL transfer_block
		
		PRINT msg2, msg2_len
		PRINT msg3, msg3_len
		MOV rsi, sblock
		CALL display_block
		
		PRINT msg4, msg4_len
		MOV rsi, dblock-6
		CALL display_block
		
		PRINT br, br_len
	 	
 		EXIT
 		
 	display_block:
 		MOV rbp, 10
 		
 		next_num:
 			MOV al, [rsi]
 			PUSH rsi
 			CALL display
 			PRINT space, 1
 			POP rsi
 			INC rsi
 			DEC rbp
 			JNZ next_num
 		ret
 		
 	display:
 		MOV rsi, char_ans+1
 		MOV rcx, 2
 		MOV rbx, 16
 		
 		next_digit:
 			XOR rdx, rdx
 			DIV rbx
 			CMP dl, 09h
 			JBE add30h
 			ADD dl, 07h
 			
 		add30h:
 			ADD dl, 30h
 			MOV [rsi], dl
 			DEC rsi
 			DEC rcx
 			JNZ next_digit
 			PRINT char_ans, 2
 		ret
 	
 	transfer_block:
		MOV rcx, 10
		MOV rsi, sblock+9
		MOV rdi, dblock+3
		STD
		REP MOVSB
 		ret

