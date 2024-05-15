		AREA Counter, CODE, READONLY

; Define constants
DELAY_COUNT EQU 1000000 ; 1 second delay (adjust according to your processor speed)

; GPIO Register addresses
GPIO_BASE   EQU 0x20200000
GPFSEL0     EQU GPIO_BASE + 0x00
GPSET0      EQU GPIO_BASE + 0x1C
GPCLR0      EQU GPIO_BASE + 0x28

; Define BCD digits
BCD_DIGITS  DCD 0x00000000, 0x00000001, 0x00000002, 0x00000003, \
            0x00000004, 0x00000005, 0x00000006, 0x00000007, \
            0x00000008, 0x00000009

            ENTRY

START       MOV R0, #0            ; Initialize counter
            MOV R1, #0            ; Initialize delay counter

LOOP        LDR R2, BCD_DIGITS   ; Load BCD digit from memory
            MOV R3, R2, LSR #28   ; Extract the tens digit
            MOV R4, R2, LSR #24   ; Extract the ones digit

            ; Output tens digit
            MOV R5, R3, LSL #1
            MOV R6, #0
            LDR R7, GPFSEL0
            LDR R8, =0b001 << R5
            STR R8, [R7, #0]
            LDR R7, GPSET0
            LDR R8, =1 << R6
            STR R8, [R7, #0]
            LDR R7, GPCLR0
            LDR R8, =1 << R6
            STR R8, [R7, #0]

            ; Output ones digit
            MOV R5, R4, LSL #1
            MOV R6, #0
            LDR R7, GPFSEL0
            LDR R8, =0b001 << R5
            STR R8, [R7, #0]
            LDR R7, GPSET0
            LDR R8, =1 << R6
            STR R8, [R7, #0]
            LDR R7, GPCLR0
            LDR R8, =1 << R6
            STR R8, [R7, #0]

DELAY       SUBS R1, R1, #1       ; Decrement delay counter
            BNE DELAY             ; Loop until delay counter becomes zero

            ADDS R0, R0, #1       ; Increment counter
            MOV R1, #DELAY_COUNT ; Reset delay counter

            CMP R0, #99           ; Check if counter reaches 99
            BLE LOOP              ; Loop if not reached

END         B END

            END
