	AREA STRING_OPERATIONS, CODE, READONLY
    ENTRY
    EXPORT main
    
string1     DCB "Hello", 0  
string2     DCB "Helloo", 0   

main
    LDR R0, =string1    
    LDR R1, =string2    
    
    BL strstr           
    B STOP

strstr
    PUSH {LR}           
    
    MOV R2, R0          
    MOV R3, R1          
	ADD R2, R2, #1
	ADD R3, R3, #1
    
SEARCH_LOOP
    LDRB R4, [R2]  ; Load byte from string1, increment pointer
    
    ; Check if the current character in string1 matches the first character of string2
    CMP R4, #0          ; Check if end of string1 is reached
    BEQ NOT_FOUND       ; If end of string1 is reached without finding a match, return 0
    
    MOV R5, R3          ; Reset pointer to start of string2
    
COMPARE_LOOP
    LDRB R6, [R2], #1  ; Load byte from string1, increment pointer
    LDRB R7, [R5], #1  ; Load byte from string2, increment pointer
    
    CMP R6, R7          ; Compare characters
    BNE SEARCH_LOOP     ; If characters don't match, continue searching in string1
    
    CMP R7, #0          
    BEQ FOUND_SUBSTRING
    
    B COMPARE_LOOP      
    
FOUND_SUBSTRING
    MOV R0, #1
	LDR R9, = RESULT
	MOV R9, R0
    B EXIT_STRSTR       

NOT_FOUND
    MOV R0, #0  
	LDR R9, = RESULT
	MOV R9, R0
	B EXIT_STRSTR
    
EXIT_STRSTR
    POP {PC}           

STOP
    B STOP              

	AREA STORE, DATA, READWRITE
RESULT DCD 0
	END
