		AREA test, CODE, READONLY
		ENTRY                ; Entry point to the program
		EXPORT main          ; Exporting __main symbol

buffer
    DCD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ; 2D array elements

main
    ADR R0, buffer    ; Load the base address of the 2D array into R0

    ; Initialize variables
    MOV R1, #0        ; Row index
    MOV R2, #0        ; Column index
    MOV R3, #3        ; Number of rows
    MOV R4, #3        ; Number of columns

    ; Calculate index in the 2D array: index = (row * number_of_columns) + column
    MUL R1, R1, R4    ; row * number_of_columns
    ADD R1, R1, R2    ; row * number_of_columns + column

    ; Accessing an element using register indirect addressing mode
    LDR R5, [R0, R1, LSL #2] ; Load the value at buffer[row][column] (assuming each element is 4 bytes)

    ; Now R5 contains the value of buffer[row][column]

    ; Your code after accessing the element goes here

Stop    B Stop

end
