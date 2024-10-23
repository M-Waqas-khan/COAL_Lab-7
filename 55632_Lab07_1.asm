.MODEL SMALL
.STACK 100H

.DATA
    newline DB 0Dh, 0Ah, '$'        ; Carriage return and line feed
    prompt1 DB "The original string: $"
    prompt2 DB "The reversed string: $"
    string1 DB "also", 0           ; Original string
    reversedString DB 5 DUP('$')    ; Space for reversed string

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display original string with a newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    LEA DX, prompt1
    MOV AH, 09H
    INT 21H

    LEA DX, string1
    MOV AH, 09H
    INT 21H

    ; Insert a newline before displaying reversed string
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Reverse the string
    LEA SI, string1
    LEA DI, reversedString
    CALL reverseString

    ; Display reversed string with a newline
    LEA DX, prompt2
    MOV AH, 09H
    INT 21H

    LEA DX, reversedString
    MOV AH, 09H
    INT 21H

    ; Insert a newline after displaying the reversed string
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedure to reverse a string
reverseString PROC
    ; Calculate length of the string
    MOV CX, 0                 ; Initialize length counter
    MOV BX, SI                ; Use BX as the pointer to the string

L1:
    MOV AL, [BX]              ; Load byte from the string using BX
    CMP AL, 0                 ; Check for null terminator
    JE L2                     ; Exit loop if null terminator found
    INC BX                    ; Move to the next character in the string
    INC CX                    ; Increment length counter
    JMP L1                    ; Repeat until null terminator

L2:
    DEC BX                    ; Adjust BX to point to the last character
    DEC CX                    ; Adjust CX to point to last valid index

    ; Copy characters in reverse
L3:
    MOV AL, [BX]              ; Load character from the end of string
    MOV [DI], AL              ; Store character in reversed string
    INC DI                    ; Move to next position in reversed string
    DEC BX                    ; Move to previous character in original string
    LOOP L3                   ; Repeat for all characters

    MOV BYTE PTR [DI], 0      ; Add null terminator to reversed string
    RET
reverseString ENDP

END MAIN
