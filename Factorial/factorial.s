	AREA factorial, CODE, READONLY
	ENTRY
	EXPORT main
NUM EQU 10
main	
	LDR R1 ,=NUM
	MOV R2, #1
	BL Fact					; Call Subroutine
	LDR R3, =RESULT
	STR R2,[R3]
	
Stop B Stop	

Fact
	CMP R1, #1
	MULGT R2, R2, R1		;If R1>1
	SUBGT R1, R1, #1
	BGT Fact
	BX LR					;Return next pointer which was linked after Subr0utine
	
	AREA STORE, DATA, READWRITE
RESULT DCD 0x00000000
	END