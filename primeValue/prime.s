	AREA PRIME, CODE, READONLY
	ENTRY
	EXPORT main
ARR DCD 2, 3, 1 ,4, 6 , 5 ,7 ,4

prime
	CMP R4, #1
	BEQ not_prime
	MOV R5, #2
LOOP 
	CMP R4, R5
	BEQ ok_prime
	MOV R6, R4
	SDIV R6, R6, R5
	MUL R6, R6, R5
	CMP R6, R4
	BEQ not_prime
	ADD R5, R5, #1
	B LOOP	
not_prime
	MOV R4, #0
	BX LR
ok_prime
	MOV R4, #1
	BX LR

main
	MOV R0, #8
	MOV R1, #0
	ADR R3, ARR
	BL check_prime
check_prime
	CMP R1, R0
	BEQ STOP
	LDR R4 ,[R3]
	ADD R3, R3, #4
	ADD R1, R1, #1
	BL prime
	B check_prime
STOP B STOP
	END