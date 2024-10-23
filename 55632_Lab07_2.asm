.MODEL SMALL
.STACK 100H

.DATA
    num1 DW 5              ; First number
    num2 DW 10             ; Second number
    num3 DW 15             ; Third number
    sum  DW 0              ; To store the sum

    prompt1 DB "The sum of three digits is:$"
    prompt2 DB "Answer: $"
    newline DB 0Dh, 0Ah, '$'   ; Newline

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Call procedure to calculate sum
    CALL addThreeNumbers

    ; Display messages and result
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    LEA DX, prompt1
    MOV AH, 09H
    INT 21H

    LEA DX, newline
    MOV AH, 09H
    INT 21H

    LEA DX, prompt2
    MOV AH, 09H
    INT 21H

    ; Display sum
    MOV AX, sum
    CALL displayNumber

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedure to add three numbers
addThreeNumbers PROC
    MOV AX, num1          ; Load first number into AX
    ADD AX, num2          ; Add second number
    ADD AX, num3          ; Add third number
    MOV sum, AX           ; Store result in 'sum'
    RET
addThreeNumbers ENDP

; Procedure to display a number
displayNumber PROC
    ; Convert and display number in AX
    MOV BX, 10            ; Divisor for decimal conversion
    XOR CX, CX            ; Clear CX for digit count

convert:
    XOR DX, DX            ; Clear DX
    DIV BX                ; AX / 10, remainder in DX
    ADD DL, '0'           ; Convert remainder to ASCII
    PUSH DX               ; Save digit on stack
    INC CX                ; Count digits
    CMP AX, 0             ; Check if AX is zero
    JNE convert           ; Repeat if not

print:
    POP DX                ; Get digit from stack
    MOV AH, 02H           ; Print character
    INT 21H
    LOOP print            ; Repeat for all digits
    RET
displayNumber ENDP

END MAIN
