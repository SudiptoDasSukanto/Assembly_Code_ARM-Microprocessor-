	AREA evenOdd, CODE,  READONLY
	ENTRY
	EXPORT main
ARR DCD 0x00000000, 0x44444444, 0x11111111, 0xAAA1025A, 0xFFFFFFFF
main
	MOV R8, #0						;store even number
	MOV R9, #0						;store odd number
	LDR R0, =ARR
	LDR R5, [R0], #4	
LOOP
	LDR R2,[R0], #4
	LSRS R2,#1
	BCC EVEN						;if carry==0 than go to even
	ADD R9, R9, #1
	BAL XX							; Always jump
	
EVEN
	ADD R8, R8, #1
XX
	SUBS R5, R5, #1
	BNE LOOP
	
	LDR R4, = RESULT
	STMIA R4!,{R8,R9}					; STORE R8 in R4 and R9 in R4+4
	
STOP B STOP
	AREA STORE, DATA, READWRITE
RESULT DCD 0X0, 0X0
	END