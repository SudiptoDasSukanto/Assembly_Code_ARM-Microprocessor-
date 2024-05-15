		AREA test, CODE, READONLY
		ENTRY                ; Entry point to the program
		EXPORT main          ; Exporting __main symbol

; Define constants
SIZE        EQU 4    ; Size of the BCD array (4 digits)

; Define the BCD array
BCD_array   DCD 0x12, 0x34, 0x56, 0x78   ; BCD array (example data)

; Define the binary array to store the result
binary_array SPACE SIZE    ; Space for the binary array

main
    ADR R0, BCD_array    ; Load the base address of the BCD array into R0
    ADR R1, binary_array ; Load the base address of the binary array into R1

    MOV R2, #0           ; Initialize loop counter

convert_loop
    LDRB R3, [R0, R2]    ; Load the current BCD byte into R3

    ; Extract the upper and lower nibbles (digits)
    MOVS R4, R3, LSR #4  ; R4 = upper nibble
    ANDS R3, R3, #0xF    ; R3 = lower nibble

    ; Convert the upper nibble to binary
    MUL R4, R4, #10      ; Multiply the upper nibble by 10
    ADD R5, R4, R3       ; Add the lower nibble to the result

    ; Store the binary result in the binary array
    STRB R5, [R1, R2]    ; Store the binary result in the binary array

    ADD R2, R2, #1       ; Move to the next digit in the arrays

    CMP R2, #SIZE        ; Compare loop counter with the size of the array
    BLT convert_loop     ; If not reached the end, continue the loop

Stop    B Stop

end
