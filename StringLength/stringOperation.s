	AREA STRING_OPERATIONS, CODE, READONLY
    ENTRY
    EXPORT main
    
    ; String declaration
myString    DCB "Hello, ARM!", 0  ; Define a string terminated with null character ('\0')
    
    ; Entry point of the program
main
    ; Load the address of myString into R1
    LDR R1, =myString   ; R1 = &myString[0]
    
    ; Calculate the length of the string
    BL strlen            ; Call the strlen function to calculate the length
    
    ; Store the string length in memory
    LDR R4, =RESULT      ; Load the address of RESULT
    STR R0, [R4]         ; Store the string length at the memory location RESULT
    
    ; Halt execution (infinite loop)
STOP
    B STOP               ; Infinite loop to halt the program execution

; String length function (strlen equivalent)
strlen
    PUSH {LR}            ; Preserve return address
    
    ; Initialize length counter and string pointer
    MOV R0, #0           ; R0 = length counter
    MOV R2, R1           ; R2 = pointer to the string
    
LOOP_LENGTH
    LDRB R3, [R2], #1   ; Load byte from string, increment pointer
    CMP R3, #0           ; Compare byte with null terminator ('\0')
    BEQ END_LENGTH       ; Exit loop if null terminator is found
    ADD R0, R0, #1       ; Increment length counter
    B LOOP_LENGTH        ; Repeat until null terminator is found
    
END_LENGTH
    POP {PC}             ; Return from function

	AREA STORE, DATA, READWRITE
RESULT DCD 0x0           ; Storage for the string length

	END
