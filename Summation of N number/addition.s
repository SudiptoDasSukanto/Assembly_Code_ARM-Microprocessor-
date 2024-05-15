	AREA ADDITION, CODE, READONLY
	ENTRY
	EXPORT main
Array DCD 0x4, 0x0000000F, 0xF000FFFF, 0x12345678, 0xFA129032
main
	LDR R1,=Array    	; LOAD the array initial address
	LDR R5,[R1],#4		; Load the first value in R5 as size of array
	MOV R8, #0			; Lower sum will store here
	MOV R9, #0			; Upper sum will store here
LOOP
	LDR R2, [R1],#4
	ADDS R8,R2,R8
	ADC R9, R9, #0
	SUBS R5,R5, #1
	CMP R5, #0
	BNE LOOP
	LDR R4, =RESULT
	STR R8,[R4],#4
	STR R9,[R4]
STOP B STOP	
	AREA STORE, DATA, READWRITE
RESULT DCD 0x0, 0x0
	END
		
	
	