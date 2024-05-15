	AREA MYDATA, DATA, READWRITE
	
arr dcd 1,2,3,4,5,6,7,8,9   ; Define the 2D array of integers in Row major
; Define the 2D array in row-major order
	
	AREA Task1, CODE, READONLY
    ENTRY
    EXPORT main

main

    LDR R0, =arr      ; Load the base address of the array into R0
	LDR R6, [R0]
    MOV R1, #3        ; Number of columns/rows in the array (assuming square)
    MOV R2, #2        ; Row index
    MOV R3, #2        ; Column index
    MOV R4, #0        ; Initialize R4 to hold the calculated offset
	MOV R5, #4
    MUL R4, R2, R1    ; Multiply the row index (R2) by the number of columns (R1)
    ADD R4, R4, R3    ; Add the column index (R3) to the result
    MUL R4, R4, R5    ; Multiply the offset by 4 to account for each element being 4 bytes (assuming integers)
    ADD R4, R4, R0    ; Add the base address of the array to the offset
	LDR R6, [R4]

  
STOP  B STOP
    END
