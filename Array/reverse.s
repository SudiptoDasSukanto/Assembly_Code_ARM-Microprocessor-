	AREA REVERSE, CODE, READONLY
	ENTRY
	EXPORT main
ARR DCD 1, 2, 3, 4, 5
main
	BL REVERSE_ARRAY
REVERSE_ARRAY
	ADR R0, ARR
	ADR R1, ARR
	ADD R1, R1, #16
LOOP
		STR R0, [R1]
		ADD R0, R0, #4
		SUB R1, R1, #4
		CMP R0, #20
		BNE LOOP
		
STOP B STOP 
	END
	