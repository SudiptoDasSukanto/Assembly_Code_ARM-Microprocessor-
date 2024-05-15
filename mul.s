		AREA test, CODE, READONLY
		ENTRY                ; Entry point to the program
		EXPORT main          ; Exporting __main symbol

; Define constants
DIMENSION   EQU 3    ; Dimension of the matrices (3x3)
SIZE        EQU DIMENSION*DIMENSION ; Size of each matrix

; Define the matrices
matrix1     DCD 1, 2, 3, 4, 5, 6, 7, 8, 9   ; First matrix
matrix2     DCD 9, 8, 7, 6, 5, 4, 3, 2, 1   ; Second matrix

result      SPACE SIZE    ; Space for the result matrix

main
    ADR R0, matrix1    ; Load the base address of the first matrix into R0
    ADR R1, matrix2    ; Load the base address of the second matrix into R1
    ADR R2, result     ; Load the base address of the result matrix into R2

    MOV R3, #0         ; Initialize row index for result matrix

outer_loop
    MOV R4, #0         ; Initialize column index for result matrix

    MOV R5, #0         ; Initialize column index for matrix2

    inner_loop
        MOV R6, #0     ; Initialize accumulator for the current element of the result matrix

        MOV R7, #0     ; Initialize row index for matrix1
        MOV R8, #0     ; Initialize row index for matrix2

        calculate_element
            LDR R9, [R0, R7, LSL #2]     ; Load element from matrix1
            LDR R10, [R1, R8, LSL #2]    ; Load element from matrix2

            MUL R9, R9, R10              ; Multiply corresponding elements
            ADD R6, R6, R9               ; Add the product to the accumulator

            ADD R7, R7, #1               ; Move to the next element in the current row of matrix1
            ADD R8, R8, DIMENSION        ; Move to the next row in matrix2

            CMP R7, DIMENSION            ; Check if the row index for matrix1 reached the end
            BNE calculate_element        ; If not, continue calculating the element

        STR R6, [R2, R4, LSL #2]         ; Store the calculated element in the result matrix

        ADD R4, R4, #1                   ; Move to the next column in the result matrix
        ADD R5, R5, #1                   ; Move to the next column in matrix2

        CMP R4, DIMENSION                ; Check if the column index for the result matrix reached the end
        BNE inner_loop                    ; If not, continue inner loop

    ADD R3, R3, #1                       ; Move to the next row in the result matrix

    CMP R3, DIMENSION                    ; Check if the row index for the result matrix reached the end
    BNE outer_loop                       ; If not, continue outer loop

Stop    B Stop

end
