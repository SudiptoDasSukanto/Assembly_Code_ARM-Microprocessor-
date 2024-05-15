	AREA STRING_OPERATIONS, CODE, READONLY
    ENTRY
    EXPORT main

myString    DCB "Hello, ARM!", 0  ; Define a string terminated with null character ('\0')

main
	; Load the address of myString into R1
    LDR R1, =myString   ; R1 = &myString[0]
    
    ; Reverse the string
    BL strrev            ; Call the strrev function to reverse the string
    
    ; Halt execution (infinite loop)
STOP
    B STOP               ; Infinite loop to halt the program execution

; String reversal function (strrev)
strrev
    PUSH {LR}            ; Preserve return address
    
    ; Initialize string pointers
    MOV R2, R1           ; R2 = pointer to the beginning of the string
    MOV R3, R1           ; R3 = pointer to the end of the string
    
    ; Move R3 to the last character of the string
LOOP_MOVE_END
    LDRB R4, [R3]		 ; Load byte from the end of the string, decrement pointer
    CMP R4, #0           ; Compare byte with null terminator ('\0')
    BEQ END_REVERSAL     ; Exit loop if null terminator is found
    ADD R3, R3, #1       ; Adjust R3 to point to the last character
    
    B LOOP_MOVE_END      ; Repeat until null terminator is found
    
END_REVERSAL
	SUB R3, R3, #1	   	  ; Move characters from the beginning to the end of the string
LOOP_REVERSE
	LDR R6, [R2]
    CMP R6, #0           ; Compare pointers (beginning and end of the string)
    BEQ END_REVERSE_LOOP ; Exit loop if beginning pointer >= end pointer
    
    LDRB R4, [R2]        ; Load byte from the beginning pointer
    LDRB R5, [R3]        ; Load byte from the end pointer
    STRB R5, [R2]        ; Store the byte from the end at the beginning
    STRB R4, [R3]        ; Store the byte from the beginning at the end
    
    ADD R2, R2, #1       ; Increment beginning pointer
    SUB R3, R3, #1       ; Decrement end pointer
    
    B LOOP_REVERSE       ; Repeat until beginning pointer >= end pointer
    
END_REVERSE_LOOP
    POP {PC}             ; Return from function

END
