	AREA CopyData, CODE, READONLY

    ENTRY

    ; Define source and destination arrays
    SOURCE      DCD 0x11223344, 0x55667788  ; Source array (2 words, 8 bytes)
    DESTINATION DCD 0x00000000, 0x00000000  ; Destination array (2 words, 8 bytes)

    ; Main code
    LDR R0, =SOURCE         ; Load address of source array into R0
    LDR R1, =DESTINATION    ; Load address of destination array into R1

    ; Copy 8 bytes of data
    LDR R2, [R0]            ; Load first word from source array into R2
    STR R2, [R1]            ; Store first word to destination array
    ADD R0, R0, #4          ; Move to the next word in source array
    ADD R1, R1, #4          ; Move to the next word in destination array
    LDR R2, [R0]            ; Load second word from source array into R2
    STR R2, [R1]            ; Store second word to destination array

    ; End of code
    END
