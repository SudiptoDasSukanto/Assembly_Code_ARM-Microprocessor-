	AREA STRING_OPERATIONS, CODE, READONLY
    ENTRY
    EXPORT main
    
string1     DCB "Hello", 0  ; First string terminated with null character ('\0')
string2     DCB "Hell", 0  ; Second string terminated with null character ('\0')

main
    LDR R0, =string1    ; R0 = Address of string1
    LDR R1, =string2    ; R1 = Address of string2
    
    BL strcmp           ; Call the strcmp function to compare the strings
    LDR R4, = RESULT
	STR R0, [R4]
    B STOP

strcmp
    PUSH {LR}           ; Preserve return address
    
    MOV R2, R0          ; R2 = Pointer to string1
    MOV R3, R1          ; R3 = Pointer to string2
    
    ; Compare characters until a difference is found or both strings end
COMPARE_LOOP
    LDRB R4, [R2], #1  ; Load byte from string1, increment pointer
    LDRB R5, [R3], #1  ; Load byte from string2, increment pointer
    
    CMP R4, R5          ; Compare characters
    BNE END_COMPARE     ; Branch if characters are not equal
    
    CMP R4, #0          ; Check if end of string1 is reached
    BNE COMPARE_LOOP    ; Repeat if not end of string1
    
    CMP R5, #0          ; Check if end of string2 is reached
    BNE COMPARE_LOOP    ; Repeat if not end of string2
    
    MOV R0, #0          ; Return value 0 (strings are equal)
    B EXIT_COMPARE      ; Exit comparison function

END_COMPARE
	
    SUB R0, R4, R5      ; Calculate the difference
	
    B EXIT_COMPARE      ; Exit comparison function

EXIT_COMPARE
    POP {PC}            ; Return from function

STOP
    B STOP              ; Infinite loop to halt execution
	AREA STORE, DATA, READWRITE
RESULT DCD 0
	END
