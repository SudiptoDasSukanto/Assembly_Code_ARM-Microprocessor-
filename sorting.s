		AREA test, CODE, READONLY
		ENTRY                ; Entry point to the program
		EXPORT main          ; Exporting __main symbol

; Define constants
SIZE        EQU 10   ; Size of the array

; Define the array
array       DCD 5, 2, 7, 1, 9, 3, 8, 4, 6, 0   ; Array of numbers

main
    ADR R0, array     ; Load the base address of the array into R0

    MOV R1, #0         ; Initialize outer loop counter (i)
outer_loop
    MOV R2, #0         ; Initialize inner loop counter (j)
    MOV R3, #SIZE-1    ; Initialize comparison limit for inner loop

inner_loop
    LDR R4, [R0, R2]   ; Load array[i] into R4
    LDR R5, [R0, R2, #4] ; Load array[i+1] into R5

    CMP R4, R5         ; Compare array[i] with array[i+1]
    MOVGT R6, R4       ; If array[i] > array[i+1], swap them
    MOVGT R4, R5
    MOVGT R5, R6
    STR R4, [R0, R2]   ; Store updated array[i] back
    STR R5, [R0, R2, #4] ; Store updated array[i+1] back

    ADD R2, R2, #4     ; Move to the next element in the array

    CMP R2, R3         ; Compare inner loop counter with comparison limit
    BLT inner_loop     ; If not reached the end, continue inner loop

    ADD R1, R1, #1     ; Increment outer loop counter

    CMP R1, #SIZE-1    ; Compare outer loop counter with array size - 1
    BLT outer_loop     ; If not reached the end, continue outer loop

Stop    B Stop

end
