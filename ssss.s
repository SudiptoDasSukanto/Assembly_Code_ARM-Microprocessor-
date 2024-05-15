		AREA test, CODE, READONLY
		ENTRY               ; Entry point to the program
		EXPORT main         ; Exporting __main symbol

buffer
		DCD 1,2,3,4,5,6

main
		ADR R0, buffer     ; Load the base address of the array into R0
		MOV R1, #0         ; Initialize index to 0
		MOV R3, #0         ; Initialize sum to 0
		MOV R4, #0         ; Counter for counting number of elements

loop
		LDR R2, [R0, R1]  ; Load the next element of the array into R2
		ADD R3, R3, R2    ; Add the current element to the sum
		ADD R4, R4, #1    ; Increment counter for counting number of elements
		ADD R1, R1, #4    ; Move to the next element (assuming each element is 4 bytes)

		CMP R4, #6       ; Compare index with the size of the array (assuming 6 elements of 4 bytes each)
		BNE loop          ; If not reached end, continue looping

		; At this point, R3 contains the sum of the elements
		; and R4 contains the number of elements in the array

		; Your code after the loop goes here
		
		ldr r1,[r0]
		mov r3, #4
		mov r4, #1
loop_1
	
		ldr r2, [r0,r3]
		add r3, r3, #4
		CMP R2, R1
		; If R1 > R2, set R1 to R2
		MOVGT R1, R2
		; Continue looping if not reached the end of the array
		CMP R3, #24       ; Compare index with the size of the array (assuming 6 elements of 4 bytes each)
		BNE loop_1
		
		MOV R5, #3
		
		mov r3, #0
		mov r7,#24
		mov r9 ,#0
loop_3

		ldr r2,[r0,r3];
		ldr r10,[r0,r7]
		MOV R8 ,R2
		MOV R2, R10
		MOV R10, R8
		STR R2,[R0,R3]
		STR R10,[R0,R7]
		add r3, #4
		sub r7, #4
		add r9,r9,#1
		cmp r9,r5
		bne loop_3
		
Stop 	B Stop

		end
	